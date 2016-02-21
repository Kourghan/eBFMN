
@import Foundation;

#import "ODSDataSource.h"
#import "ODSFilterable.h"

@class ODSArrayDataSource, ODSArraySection;
@class NSFetchRequest, NSManagedObjectContext;

typedef NSArray *(^ODSArraySourceGenerator)(ODSArrayDataSource *sender);

@interface ODSArrayDataSource : ODSDataSource <ODSFilterable>

- (instancetype)initWithSectionPrototype:(ODSArraySection *)prototype generator:(ODSArraySourceGenerator)generator;
+ (instancetype)sourceUsingGenerator:(ODSArraySourceGenerator)generator;
+ (instancetype)sourceUsingGenerator:(ODSArraySourceGenerator)generator sectionPrototype:(ODSArraySection *)prototype;

// remove all data
- (void)reset;

@property (nonatomic, strong, readonly) NSArray *sections;

- (void)performBatchUpdate:(void (^)(void))update;

- (void)addObject:(id)object;
- (void)addObject:(id)object toSection:(NSUInteger)section;
- (void)insertObject:(id)object atIndex:(NSUInteger)index toSection:(NSUInteger)section;
- (void)removeObjectAtIndex:(NSUInteger)index inSection:(NSUInteger)section;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;
- (void)removeObject:(id)object;

- (void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
- (void)moveObjectAtIndexPath:(NSIndexPath *)indexPath to:(NSIndexPath *)toIndexPath;

- (void)addSection:(ODSArraySection *)section;
- (void)insertSection:(ODSArraySection *)section atIndex:(NSUInteger)index;
- (void)removeSectionAtIndex:(NSUInteger)index;

@end

@interface ODSArrayDataSource (ExtendedInit)

+ (instancetype)sourceFromArray:(NSArray *)array;
+ (instancetype)sourceFromFetchRequest:(NSFetchRequest *)fetchRequest context:(NSManagedObjectContext *)context;

@end