
#import <Foundation/Foundation.h>

@protocol ODSEventSubscriber, ODSSection;

@interface ODSDataSource : NSObject <NSFastEnumeration>

- (void)addSubscriber:(id<ODSEventSubscriber>)subscriber;
- (void)removeSubscriber:(id<ODSEventSubscriber>)subscriber;

#pragma mark - Access

- (NSInteger)numberOfSections;
- (id<ODSSection>)sectionAtIndex:(NSUInteger)index;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForObject:(id)object;

#pragma mark - Data Update
/**
* Mark update flag as dirty. Lazy update
*/
- (void)setNeedsReload;

/**
* Perform update if needed
*/
- (void)reloadIfNeeded;
/**
* Force update
*/
- (void)reload;


- (void)performReload;

// Batch updates
- (void)beginUpdate;
- (void)endUpdate;
@property (nonatomic, readonly, getter=isUpdating) BOOL updating;

// source will not notify subscribers about any internal change
- (void)performSuppressingChangesPropagation:(void (^)(void))changes;

// O(n) for given number of sections
@property (nonatomic, readonly) NSUInteger totalObjectsCount;
- (BOOL)isEmpty;

@end

@interface ODSDataSource (Subscription)

- (id<ODSSection>)objectAtIndexedSubscript:(NSUInteger)index;
- (id)objectForKeyedSubscript:(NSIndexPath *)indexPath;

@end
