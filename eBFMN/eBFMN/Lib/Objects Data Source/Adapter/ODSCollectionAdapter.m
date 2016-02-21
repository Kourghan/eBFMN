//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

#import "ODSCollectionAdapter.h"
#import "ODSAdapter+Protected.h"

#import "ODSEvent.h"
#import "ODSObjectChange.h"
#import "ODSSectionChange.h"
#import "ODSDataSource.h"
#import "ODSArraySection.h"
#import "ODSBatchObjectChange.h"

@interface ODSCollectionAdapter ()

@property (nonatomic, strong) NSMutableArray *pendingEvents;
@property (nonatomic) BOOL collectingUpdateEvents;

@end

@implementation ODSCollectionAdapter

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _pendingEvents = [[NSMutableArray alloc] init];
        _collectingUpdateEvents = NO;
    }

    return self;
}

#pragma mark - CollectionView

- (void)setCollectionView:(UICollectionView *)collectionView {
    if (_collectionView == collectionView) {
        return;
    }

    [_collectionView setDataSource:nil];
    [_collectionView setDelegate:nil];
    
    _collectionView = collectionView;
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];

    [self setNeedsReload];
}

#pragma mark - ODSAdapter

- (void)reloadAnimated:(BOOL)animated {
    if (animated) {
        NSRange reloadRange = (NSRange){0, (NSUInteger)self.collectionView.numberOfSections};
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:reloadRange]];
    } else {
        [self.collectionView reloadData];
    }
}

- (id)cellForIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (id)cellAtIndexPath:(NSIndexPath *)indexPath {
    return [self.collectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark - Changes applying

- (void)applyObjectChangeEvent:(ODSEvent *)event {
    ODSObjectChange *change = event.objectChange;
    NSParameterAssert(change != nil);

    switch (change.type) {
        case ODSChangeTypeInsert:
            [self.collectionView insertItemsAtIndexPaths:@[change.targetIndexPath]];
            break;

        case ODSChangeTypeDelete:
            [self.collectionView deleteItemsAtIndexPaths:@[change.sourceIndexPath]];
            break;

        case ODSChangeTypeMove:
            [self.collectionView moveItemAtIndexPath:change.sourceIndexPath toIndexPath:change.targetIndexPath];
            break;

        case ODSChangeTypeUpdate:
            [self.collectionView reloadItemsAtIndexPaths:@[change.sourceIndexPath]];
            break;
    }
}

- (void)applySectionChangeEvent:(ODSEvent *)event {
    ODSSectionChange *change = event.sectionChange;
    NSParameterAssert(change != nil);

    switch (change.type) {
        case ODSChangeTypeInsert:
            [self.collectionView insertSections:change.indexes];
            break;

        case ODSChangeTypeDelete:
            [self.collectionView deleteSections:change.indexes];
            break;

        case ODSChangeTypeUpdate:
            [self.collectionView reloadSections:change.indexes];
            break;

        case ODSChangeTypeMove:
            // ?
            break;
    }
}

- (void)applyEvents:(NSArray *)events {
    for (ODSEvent *event in events) {
        if (event.type == ODSEventTypeObjectChange) {
            [self applyObjectChangeEvent:event];
        } else if (event.type == ODSEventTypeSectionChange) {
            [self applySectionChangeEvent:event];
        }
    }
}

- (void)dataSource:(ODSDataSource *)dataSource sentEvent:(ODSEvent *)event {
    switch (event.type) {
        case ODSEventTypeReload:
            [self.collectionView reloadData];
            break;

        case ODSEventTypeWillBeginUpdate:
            self.collectingUpdateEvents = YES;
            break;

        case ODSEventTypeDidEndUpdate: {
            self.collectingUpdateEvents = NO;
            [self applyEvents:self.pendingEvents];
            [self.pendingEvents removeAllObjects];
        }
            break;

        case ODSEventTypeBatchObjectChange:
//            abort();
            break;

        case ODSEventTypeObjectChange: {
            if (self.collectingUpdateEvents) {
                [self.pendingEvents addObject:event];
            } else {
                [self applyObjectChangeEvent:event];
            }
        }
            break;

        case ODSEventTypeSectionChange: {
            if (self.collectingUpdateEvents) {
                [self.pendingEvents addObject:event];
            } else {
                [self applySectionChangeEvent:event];
            }
        }
            break;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataSource numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.dataSource sectionAtIndex:(NSUInteger)section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self configuredCellForObjectAtIndexPath:indexPath];
}

@end