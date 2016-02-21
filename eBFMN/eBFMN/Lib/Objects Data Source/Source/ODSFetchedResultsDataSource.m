#import <mach-o/loader.h>
#import "ODSFetchedResultsDataSource.h"
#import "ODSDataSource+Protected.h"

#import "ODSArraySection.h"
#import "ODSFetchedResultsSection.h"
#import "ODSEventSubscriber.h"
#import "ODSSectionChange.h"
#import "ODSObjectChange.h"
#import "ODSBatchObjectChange.h"

@interface ODSFetchedResultsDataSource () <NSFetchedResultsControllerDelegate> {
	NSPredicate *_defaultPredicate;
    NSInteger _defaultFetchLimit;
}

@property (nonatomic, strong) NSFetchedResultsController *controller;
@property (nonatomic, strong) NSMutableArray *sections;

@property (nonatomic, strong) NSMutableIndexSet *insertedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *deletedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *updatedSectionIndexes;

@property (nonatomic, strong) NSMutableArray *insertedIndexPaths;
@property (nonatomic, strong) NSMutableArray *deletedIndexPaths;
@property (nonatomic, strong) NSMutableArray *updatedIndexPaths;

@property (nonatomic, strong) NSFetchedResultsController *defaultController;

@end

@implementation ODSFetchedResultsDataSource

@synthesize awaitsPredicate = _awaitsPredicate;
@synthesize predicate = _predicate;

#pragma mark - Init

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController {
	NSParameterAssert(fetchedResultsController);
	self = [super init];
	if (self) {
        _defaultFetchLimit = fetchedResultsController.fetchRequest.fetchLimit;
        _defaultPredicate = fetchedResultsController.fetchRequest.predicate;
        _defaultController = fetchedResultsController;

        self.sections = [[NSMutableArray alloc] init];
        
		if (!fetchedResultsController.fetchedObjects) {
			[self setNeedsReload];
		}

		[self setController:fetchedResultsController];
		[fetchedResultsController setDelegate:self];
	}

	return self;
}

+ (instancetype)fetchedResultsControllerSource:(NSFetchedResultsController *)fetchedResultsController {
	return [[self alloc] initWithFetchedResultsController:fetchedResultsController];
}

#pragma mark - Filter

- (void)setPredicate:(NSPredicate *)predicate {
	if (_predicate == predicate) return;

	_predicate = predicate;

	NSMutableArray *predicates = [[NSMutableArray alloc] initWithObjects:_defaultPredicate, nil];
	if (_predicate) {
		[predicates addObject:_predicate];
	}
	NSPredicate *finalPredicate = predicates.count > 0 ? [NSCompoundPredicate andPredicateWithSubpredicates:predicates]: nil;
    if (self.controller == nil) {
        self.controller = self.defaultController;
        [self.controller setDelegate:self];
    }
	[self.controller.fetchRequest setPredicate:finalPredicate];
	[self setNeedsReload];
}

- (void)setAwaitsPredicate:(BOOL)awaitsPredicate {
    if (_awaitsPredicate == awaitsPredicate) {
        return;
    }
    
    _awaitsPredicate = awaitsPredicate;
    
    [self setNeedsReload];
}

#pragma mark - Properties

- (NSFetchedResultsController *)controller {
	[self reloadIfNeeded];

	return _controller;
}

- (NSMutableArray *)sections {
    [self reloadIfNeeded];

    return _sections;
}

#pragma mark - Update

- (void)reloadSections:(BOOL)refetch {
	[_sections removeAllObjects];

    if (refetch) {
        for (id<NSFetchedResultsSectionInfo> sectionInfo in self.controller.sections) {
            ODSFetchedResultsSection *section = [[ODSFetchedResultsSection alloc] initWithSectionInfo:sectionInfo];
            [_sections addObject:section];
        }
    }
}

- (void)performReload {
    if (self.awaitsPredicate && !self.predicate) {
        self.controller.delegate = nil;
        self.controller = nil;
        [self reloadSections:NO];
    } else {
        __autoreleasing NSError *error = nil;
        [_controller performFetch:&error];
        
        [self reloadSections:YES];
        
        NSAssert(!error, @"Fetch error:%@", error);
    }
}

#pragma mark - Access

- (NSInteger)numberOfSections {
    return self.controller.sections.count;
}

- (id<ODSSection>)sectionAtIndex:(NSUInteger)index {
    id sectionInfo = self.controller.sections[index];
	return sectionInfo;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
	return [self.controller objectAtIndexPath:indexPath];
}

- (NSIndexPath *)indexPathForObject:(id)object {
	return [self.controller indexPathForObject:object];
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained[])buffer count:(NSUInteger)len {
    return [self.controller.sections countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark - Section Indexing

- (NSArray *)sectionIndexTitles {
	return self.controller.sectionIndexTitles;
}

- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return [self.controller sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark - Changes Processing

- (void)processSectionChanges {
    BOOL hasSectionChange =
        self.deletedSectionIndexes.count > 0 ||
        self.insertedSectionIndexes.count > 0 ||
        self.updatedSectionIndexes.count > 0;

    if (hasSectionChange) {
        [self reloadSections:YES];
    }

    NSDictionary *changes = @{
        @(ODSChangeTypeDelete): self.deletedSectionIndexes,
        @(ODSChangeTypeInsert): self.insertedSectionIndexes,
        @(ODSChangeTypeUpdate): self.updatedSectionIndexes
    };
    ODSChangeType types[] = {ODSChangeTypeDelete, ODSChangeTypeInsert, ODSChangeTypeUpdate};

    for (NSInteger index = 0; index < sizeof(types) / sizeof(ODSChangeType); index++) {
        ODSChangeType type = types[index];
        NSMutableIndexSet *indexes = changes[@(type)];
        if (indexes.count > 0) {
            ODSSectionChange *change = [[ODSSectionChange alloc] initWithType:type indexes:indexes];
            [self propagateSectionChange:change];
        }
    }
}

- (void)processObjectChanges {
    NSDictionary *changes = @{
        @(ODSChangeTypeDelete): self.deletedIndexPaths,
        @(ODSChangeTypeInsert): self.insertedIndexPaths,
        @(ODSChangeTypeUpdate): self.updatedIndexPaths
    };
    ODSChangeType types[] = {ODSChangeTypeDelete, ODSChangeTypeInsert, ODSChangeTypeUpdate};

    for (NSInteger index = 0; index < sizeof(types) / sizeof(ODSChangeType); index++) {
        ODSChangeType type = types[index];
        NSMutableArray *indexPaths = changes[@(type)];
        if (indexPaths.count > 0) {
            ODSBatchObjectChange *change = [[ODSBatchObjectChange alloc] initWithType:type indexPaths:indexPaths];
            [self propagateBatchObjectChange:change];
        }
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.insertedSectionIndexes = [NSMutableIndexSet new];
    self.deletedSectionIndexes = [NSMutableIndexSet new];
    self.updatedSectionIndexes = [NSMutableIndexSet new];

    self.insertedIndexPaths = [NSMutableArray new];
    self.deletedIndexPaths = [NSMutableArray new];
    self.updatedIndexPaths = [NSMutableArray new];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self beginUpdate];

    [self processSectionChanges];
    [self processObjectChanges];

    [self endUpdate];
#warning lib changed
    [self reload];
    
    self.insertedSectionIndexes = nil;
    self.deletedSectionIndexes = nil;
    self.updatedSectionIndexes = nil;
    
    self.insertedIndexPaths = nil;
    self.deletedIndexPaths = nil;
    self.updatedIndexPaths = nil;
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.insertedSectionIndexes addIndex:sectionIndex];
            break;

        case NSFetchedResultsChangeDelete:
            [self.deletedSectionIndexes addIndex:sectionIndex];
            break;

        case NSFetchedResultsChangeUpdate:
            [self.updatedSectionIndexes addIndex:sectionIndex];
            break;

        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)object
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            if (![self.insertedSectionIndexes containsIndex:newIndexPath.section]) {
                [self.insertedIndexPaths addObject:newIndexPath];
            }
            break;

        case NSFetchedResultsChangeDelete:
            if (![self.deletedSectionIndexes containsIndex:indexPath.section]) {
                [self.deletedIndexPaths addObject:indexPath];
            }

            break;

        case NSFetchedResultsChangeUpdate:
            if (![self.updatedSectionIndexes containsIndex:indexPath.section]) {
                [self.updatedIndexPaths addObject:indexPath];
            }
            break;

        case NSFetchedResultsChangeMove:
            if (![self.insertedSectionIndexes containsIndex:newIndexPath.section]) {
                [self.insertedIndexPaths addObject:newIndexPath];
            }

            if (![self.deletedSectionIndexes containsIndex:indexPath.section]) {
                [self.deletedIndexPaths addObject:indexPath];
            }
            break;
    }
}

@end