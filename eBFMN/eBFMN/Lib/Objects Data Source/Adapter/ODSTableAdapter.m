//
// ODSTableAdapter.m
//
// Created by dmitriy on 12/12/13
// Copyright (c) 2013 Yalantis. All rights reserved.
//
#import "ODSTableAdapter.h"
#import "ODSAdapter+Protected.h"

#import "ODSDataSource.h"
#import "ODSArraySection.h"
#import "ODSEvent.h"
#import "ODSSectionChange.h"
#import "ODSObjectChange.h"
#import "NSException+ODSExtension.h"
#import "ODSBatchObjectChange.h"

@interface ODSTableAdapter () <UITableViewDataSource, UITableViewDelegate> {
	BOOL _isReloading;
}

@property (nonatomic, strong) id selectedObject;

@end

@implementation ODSTableAdapter

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        _allowsEditing = NO;
        _allowSelection = YES;
    }

    return self;
}

#pragma mark - Properties

- (void)updateTableViewConfiguration {
    [self.tableView setAllowsSelection:self.allowSelection];
    [self.tableView setEditing:self.allowsEditing ? self.editing : NO];
}

- (void)setTableView:(UITableView *)tableView {
	if (_tableView == tableView) return;

	[_tableView setDataSource:nil];
	[_tableView setDelegate:nil];

	_tableView = tableView;

	[_tableView setDelegate:self];
	[_tableView setDataSource:self];

    [self updateTableViewConfiguration];
	[self setNeedsReload];
}

- (void)setAllowsEditing:(BOOL)allowsEditing {
    if (_allowsEditing == allowsEditing) return;

    _allowsEditing = allowsEditing;

    [self updateTableViewConfiguration];
}

- (void)setAllowSelection:(BOOL)allowSelection {
    if (_allowSelection == allowSelection) return;

    _allowSelection = allowSelection;

    [self updateTableViewConfiguration];
}

#pragma mark - Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self willChangeValueForKey:@"editing"];
    _editing = editing;
    [self didChangeValueForKey:@"editing"];

    if (self.allowsEditing) {
        [self.tableView setEditing:editing animated:animated];
    }
}

- (void)setEditing:(BOOL)editing {
    [self setEditing:editing animated:YES];
}

+ (BOOL)automaticallyNotifiesObserversOfEditing {
    return NO;
}

#pragma mark - Reload

- (void)reloadAnimated:(BOOL)animated {
	if (!self.tableView) return;

	if (animated) {
		CATransition *fade = [CATransition new];
		[fade setType:kCATransitionFade];
		[self.tableView.layer addAnimation:fade forKey:nil];
	}

	_isReloading = YES;
	[self.tableView reloadData];
	_isReloading = NO;
}

- (BOOL)isReloading {
	return _isReloading;
}

- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Selection

- (BOOL)shouldDeselectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    return self.shouldDeselectObject ? self.shouldDeselectObject(self, object, indexPath) : YES;
}

#pragma mark - ODSAdapter

- (id)cellForIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
	return [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (id)cellAtIndexPath:(NSIndexPath *)indexPath {
	return [self.tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Selection

- (NSArray *)selectedObjectsIndexPaths {
	return [self.tableView indexPathsForSelectedRows];
}

- (void)selectObjectAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	[self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionNone];

    [self setSelectedObject:indexPath ? [self.dataSource objectAtIndexPath:indexPath] : nil];
}

- (void)deselectObjectAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	[self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    [self setSelectedObject:nil];
}

#pragma mark - ODSSourceSubscriber

- (void)dataSource:(ODSDataSource *)dataSource sentEvent:(ODSEvent *)event {
    switch (event.type) {
        case ODSEventTypeReload:
            if (![self isReloading]) {
                [self setSelectedObject:nil];
                [self reloadAnimated:NO];
            }
            break;

        case ODSEventTypeWillBeginUpdate:
            [self.tableView selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self setSelectedObject:nil];

            [self.tableView beginUpdates];
            break;

        case ODSEventTypeDidEndUpdate:
            [self.tableView endUpdates];
            break;

        case ODSEventTypeSectionChange:
            [self applySectionChangeEvent:event];
            break;

        case ODSEventTypeBatchObjectChange:
            [self applyBatchObjectChangeEvent:event];
            break;

        case ODSEventTypeObjectChange:
            [self applyObjectChangeEvent:event];
            break;
    }
}

// TODO: reduce to single object change
- (void)applyObjectChangeEvent:(ODSEvent *)event {
    ODSObjectChange *change = event.objectChange;
    switch (change.type) {
        case ODSChangeTypeInsert:
            [self.tableView insertRowsAtIndexPaths:@[change.targetIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case ODSChangeTypeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[change.sourceIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case ODSChangeTypeMove:
            [self.tableView deleteRowsAtIndexPaths:@[change.sourceIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[change.targetIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case ODSChangeTypeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[change.sourceIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)applyBatchObjectChangeEvent:(ODSEvent *)event {
    ODSBatchObjectChange *change = event.batchObjectChange;
    switch (change.type) {
        case ODSChangeTypeInsert:
            [self.tableView insertRowsAtIndexPaths:change.indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case ODSChangeTypeDelete:
            [self.tableView deleteRowsAtIndexPaths:change.indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case ODSChangeTypeUpdate:
            [self.tableView reloadRowsAtIndexPaths:change.indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
}

- (void)applySectionChangeEvent:(ODSEvent *)event {
    ODSSectionChange *change = event.sectionChange;

    switch (change.type) {
        case ODSChangeTypeInsert:
            [self.tableView insertSections:change.indexes withRowAnimation:UITableViewRowAnimationNone];
            break;

        case ODSChangeTypeDelete:
            [self.tableView deleteSections:change.indexes withRowAnimation:UITableViewRowAnimationNone];
            break;

        case ODSChangeTypeUpdate:
            [self.tableView reloadSections:change.indexes withRowAnimation:UITableViewRowAnimationNone];
            break;

        case ODSChangeTypeMove:
            NSExceptionRaiseInstanceMethodIMPRequired;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.dataSource numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self.dataSource sectionAtIndex:(NSUInteger) section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [self configuredCellForObjectAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.shouldSelectObject && !self.shouldSelectObject(self, self.dataSource[indexPath], indexPath)) return nil;

    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.dataSource[indexPath];
    [self setSelectedObject:object];

    if (self.immediateSelection) {
        [tableView selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
    }

    if (self.didSelectObject) self.didSelectObject(self, object, indexPath);
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.shouldDeselectObject && !self.shouldDeselectObject(self, self.dataSource[indexPath], indexPath)) return nil;

    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedObject:nil];

    if (self.didDeselectObject) self.didDeselectObject(self, self.dataSource[indexPath], indexPath);
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectAccessoryButton) self.didSelectAccessoryButton(self, self.dataSource[indexPath], indexPath);
}

@end