
#import "ODSDataSource.h"

#import "ODSFilterable.h"

@import CoreData;

@interface ODSFetchedResultsDataSource : ODSDataSource <ODSFilterable>

@property (nonatomic, strong, readonly) NSFetchedResultsController *controller;

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;
+ (instancetype)fetchedResultsControllerSource:(NSFetchedResultsController *)fetchedResultsController;

- (NSArray *)sectionIndexTitles;
- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end