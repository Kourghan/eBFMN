//
//  BFMPendingTableAdapter.m
//  eBFMN
//
//  Created by Mykyta Shytik on 11/2/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPendingTableAdapter.h"

#import <MagicalRecord/MagicalRecord.h>
#import "BFMPendingDateHeaderView.h"
#import "BFMPointsRecord.h"
#import "BFMPendingCell.h"

#define BFM_FRC NSFetchedResultsController

@interface BFMPendingTableAdapter ()

@property (nonatomic, strong) BFM_FRC *pendingFRC;

@end

@implementation BFMPendingTableAdapter

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupFRC];
    }
    return self;
}

- (void)setupFRC {
    NSString *name = NSStringFromClass([BFMPointsRecord class]);
    NSString *key = @"expirationDate";
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:key
                                                           ascending:NO];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:name];
    request.sortDescriptors = @[desc];
    NSManagedObjectContext *ct = [NSManagedObjectContext MR_defaultContext];
    NSString *section = @"dayStartDate";
    _pendingFRC = [[BFM_FRC alloc] initWithFetchRequest:request
                                   managedObjectContext:ct
                                     sectionNameKeyPath:section
                                              cacheName:nil];
    _pendingFRC.delegate = self;
    [_pendingFRC performFetch:nil];
}

#pragma mark - Property

- (void)setTableView:(UITableView *)tableView {
    if (self.tableView != tableView) {
        _tableView = tableView;
        NSString *identifier = NSStringFromClass([BFMPendingCell class]);
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView reloadData];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert: {
            NSArray *paths = [NSArray arrayWithObject:newIndexPath];
            [tableView insertRowsAtIndexPaths:paths
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            NSArray *paths = [NSArray arrayWithObject:indexPath];
            [tableView deleteRowsAtIndexPaths:paths
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove: {
            NSArray *paths = [NSArray arrayWithObject:indexPath];
            NSArray *updatedPaths = [NSArray arrayWithObject:newIndexPath];
            [tableView deleteRowsAtIndexPaths:paths
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:updatedPaths
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert: {
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
            [self.tableView insertSections:set
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
            [self.tableView deleteSections:set
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource + Helper Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.pendingFRC.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[self.pendingFRC sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)path {
    NSString *ident = NSStringFromClass([BFMPendingCell class]);
    BFMPendingCell *cell = [tableView dequeueReusableCellWithIdentifier:ident
                                                           forIndexPath:path];
    [self configureCell:cell atIndexPath:path];
    return cell;
}

- (void)configureCell:(BFMPendingCell *)cell atIndexPath:(NSIndexPath *)path {
    BFMPointsRecord *record = [self.pendingFRC objectAtIndexPath:path];
    [cell configureWithRecord:record];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 25.f;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    NSString *name = NSStringFromClass([BFMPendingDateHeaderView class]);
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *objects = [bundle loadNibNamed:name owner:nil options:nil];
    BFMPendingDateHeaderView *view = objects.firstObject;
    
    id sectionInfo = [[self.pendingFRC sections] objectAtIndex:section];
    if ([sectionInfo numberOfObjects]) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:section];
        BFMPointsRecord *record = [self.pendingFRC objectAtIndexPath:path];
        NSDateFormatter *formatter = [[self class] pendingHeaderFormatter];
        NSString *text = [formatter stringFromDate:[record dayStartDate]];
        view.dateLabel.text = text;
    } else {
        view.dateLabel.text = @"";
    }
    
    return view;
}

#pragma mark - Private

+ (NSDateFormatter *)pendingHeaderFormatter {
    static NSDateFormatter *internalHeaderFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        internalHeaderFormatter = [NSDateFormatter new];
        internalHeaderFormatter.dateFormat = @"EEEE, MMMM d, yyyy";
    });
    return internalHeaderFormatter;
}

@end
