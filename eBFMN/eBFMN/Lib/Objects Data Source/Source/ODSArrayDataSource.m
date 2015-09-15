
#import "ODSArrayDataSource.h"
#import "ODSDataSource+Protected.h"

@import UIKit;
@import CoreData;

#import "ODSArraySection.h"
#import "ODSEventSubscriber.h"
#import "ODSEvent.h"
#import "ODSObjectChange.h"
#import "ODSSectionChange.h"
#import "ODSEventBroadcaster.h"

@interface ODSArrayDataSource () {
    ODSArraySourceGenerator _generator;
    ODSArraySection *_prototype;
}

@property (nonatomic, strong) NSMutableArray *mutableSections;

@end

@implementation ODSArrayDataSource

@synthesize predicate = _filteringPredicate;
@synthesize awaitsPredicate = _awaitsPredicate;

#pragma mark - Init

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _mutableSections = [NSMutableArray new];
        _prototype = [ODSArraySection new];
        _generator = nil;
        
        [self setNeedsReload];
    }
    
    return self;
}

- (instancetype)initWithSectionPrototype:(ODSArraySection *)prototype generator:(ODSArraySourceGenerator)generator {
	NSParameterAssert(generator);

	self = [super init];
	if (self) {
		_mutableSections = [NSMutableArray new];
		_prototype = prototype ? [prototype copy] : [ODSArraySection new];
		_generator = [generator copy];

		[self setNeedsReload];
	}

	return self;
}

+ (instancetype)sourceUsingGenerator:(ODSArraySourceGenerator)generator {
	return [[self alloc] initWithSectionPrototype:[ODSArraySection new] generator:generator];
}

+ (instancetype)sourceUsingGenerator:(ODSArraySourceGenerator)generator sectionPrototype:(ODSArraySection *)prototype {
	return [[self alloc] initWithSectionPrototype:prototype generator:generator];
}

#pragma mark -

- (NSMutableArray *)mutableSections {
	[self reloadIfNeeded];

	return _mutableSections;
}

#pragma mark - Update

- (void)performReload {
    if (_generator) {
        NSArray *generatedObjects = _generator(self);
        id firstObject = [generatedObjects firstObject];
        if ([firstObject isKindOfClass:ODSArraySection.class]) {
#ifdef DEBUG
            for (id<ODSSection> section in generatedObjects) {
                NSAssert([section isKindOfClass:ODSArraySection.class], @"All top-level objects are expected to be ODSArraySection");
            }
#endif
            [self setMutableSections:[generatedObjects mutableCopy]];
        } else {
            ODSArraySection *section = [_prototype copy];
            [section setObjects:generatedObjects];
            [self setMutableSections:[[NSMutableArray alloc] initWithObjects:section, nil]];
        }
    } else {
        self.mutableSections = [NSMutableArray new];
    }
}

- (void)reset {
    [self reload];
}

#pragma mark - Access

- (NSArray *)sections {
	return [self.mutableSections copy];
}

- (NSInteger)numberOfSections {
	return self.mutableSections.count;
}

- (id<ODSSection>)sectionAtIndex:(NSUInteger)index {
	return self.mutableSections[index];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    ODSArraySection *section = self.mutableSections[indexPath.section];
    return section.objects[indexPath.row];
}

- (NSIndexPath *)indexPathForObject:(id)object {
	if (!object) return nil;

	NSUInteger sectionIndex = 0;
	for (ODSArraySection *section in self.mutableSections) {
		NSUInteger objectIndex = [section.objects indexOfObject:object];
        if (objectIndex != NSNotFound) {
            return [NSIndexPath indexPathForItem:objectIndex inSection:sectionIndex];
        }

		sectionIndex++;
	}

	return nil;
}

#pragma mark - Mutation

- (void)performContentChange:(void (^)(void))change {
    if (self.isUpdating) {
        change();
    } else {
        [self beginUpdate];
        change();
        [self endUpdate];
    }
}

- (void)performBatchUpdate:(void (^)(void))update {
    [self performContentChange:update];
}

- (void)addObject:(id)object {
	if (![self.mutableSections lastObject]) {
		ODSArraySection *section = [_prototype copy];
		[section setObjects:@[object]];
		[self addSection:section];
	} else {
		[self addObject:object toSection:self.mutableSections.count - 1];
	}
}

- (void)addObject:(id)object toSection:(NSUInteger)sectionIndex {
    ODSArraySection *section = self.mutableSections[sectionIndex];
    [self insertObject:object atIndex:section.mutableObjects.count toSection:sectionIndex];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index toSection:(NSUInteger)sectionIndex {
    [self performContentChange:^{
        ODSArraySection *section = self.mutableSections[sectionIndex];
        [section.mutableObjects insertObject:object atIndex:index];

        ODSObjectChange *change = [[ODSObjectChange alloc] initWithType:ODSChangeTypeInsert];
        change.targetIndexPath = [NSIndexPath indexPathForItem:index inSection:sectionIndex];
        [self propagateObjectChange:change];
    }];
}

- (void)removeObjectAtIndex:(NSUInteger)index inSection:(NSUInteger)sectionIndex {
    [self performContentChange:^{
        ODSArraySection *section = self.mutableSections[sectionIndex];
        [section.mutableObjects removeObjectAtIndex:index];

        ODSObjectChange *change = [[ODSObjectChange alloc] initWithType:ODSChangeTypeDelete];
        change.sourceIndexPath = [NSIndexPath indexPathForItem:index inSection:sectionIndex];
        [self propagateObjectChange:change];
    }];
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
	[self removeObjectAtIndex:(NSUInteger)indexPath.row inSection:(NSUInteger)indexPath.section];
}

- (void)removeObject:(id)object {
	NSIndexPath *indexPath = [self indexPathForObject:object];
	if (indexPath) {
		[self removeObjectAtIndex:(NSUInteger)indexPath.row inSection:(NSUInteger)indexPath.section];
	}
}

- (void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    [self performContentChange:^{
        ODSArraySection *section = self.mutableSections[(NSUInteger)indexPath.section];
        [section.mutableObjects replaceObjectAtIndex:(NSUInteger)indexPath.row withObject:object];

        ODSObjectChange *replaceChange = [[ODSObjectChange alloc] initWithType:ODSChangeTypeUpdate];
        replaceChange.sourceIndexPath = indexPath;
        [self propagateObjectChange:replaceChange];
    }];
}

- (void)moveObjectAtIndexPath:(NSIndexPath *)indexPath to:(NSIndexPath *)toIndexPath {
    [self performContentChange:^{
        ODSArraySection *fromSection = self.mutableSections[(NSUInteger)indexPath.section];
        ODSArraySection *toSection = self.mutableSections[(NSUInteger)indexPath.section];

        id object = fromSection.mutableObjects[(NSUInteger)indexPath.row];
        [fromSection.mutableObjects removeObjectAtIndex:(NSUInteger)indexPath.row];
        [toSection.mutableObjects insertObject:object atIndex:(NSUInteger)toIndexPath.row];

        ODSObjectChange *change = [[ODSObjectChange alloc] initWithType:ODSChangeTypeMove];
        change.sourceIndexPath = indexPath;
        change.targetIndexPath = toIndexPath;
        [self propagateObjectChange:change];
    }];
}

- (void)addSection:(ODSArraySection *)section {
    [self insertSection:section atIndex:self.mutableSections.count];
}

- (void)insertSection:(ODSArraySection *)section atIndex:(NSUInteger)index {
    [self performContentChange:^{
        [self.mutableSections insertObject:section atIndex:index];

        ODSSectionChange *change = [[ODSSectionChange alloc] initWithType:ODSChangeTypeInsert index:index];
        [self propagateSectionChange:change];
    }];
}

- (void)removeSectionAtIndex:(NSUInteger)index {
    [self performContentChange:^{
        [self.mutableSections removeObjectAtIndex:index];

        ODSSectionChange *change = [[ODSSectionChange alloc] initWithType:ODSChangeTypeDelete index:index];
        [self propagateSectionChange:change];
    }];
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
	return [self.mutableSections countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark - ODSFilteringSource

- (void)setPredicate:(NSPredicate *)predicate {
    if (_filteringPredicate == predicate) return;

    _filteringPredicate = predicate;

    [self reload];
}

@end

@implementation ODSArrayDataSource (ExtendedInit)

+ (instancetype)sourceFromArray:(NSArray *)array {
	NSArray *arrayCopy = [array copy];
	return [[self alloc] initWithSectionPrototype:[ODSArraySection new] generator:^NSArray *(ODSArrayDataSource *sender) {
        if (sender.predicate) {
            return [arrayCopy filteredArrayUsingPredicate:sender.predicate];
        } else {
            return arrayCopy;
        }
    }];
}

+ (instancetype)sourceFromFetchRequest:(NSFetchRequest *)fetchRequest context:(NSManagedObjectContext *)context {
	NSParameterAssert(fetchRequest);
	NSParameterAssert(context);

	return [[self alloc] initWithSectionPrototype:nil generator:^NSArray *(ODSArrayDataSource *sender) {
		__autoreleasing NSError *error = nil;

        NSPredicate *originalPredicate = sender.predicate ? fetchRequest.predicate : nil;
        if (originalPredicate) {
            NSArray *predicates = [[NSArray alloc] initWithObjects:originalPredicate, sender.predicate, nil];
            [fetchRequest setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
        }

		NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];

        if (originalPredicate) {
            [fetchRequest setPredicate:originalPredicate];
        }

		NSAssert(!error, @"Fetch error:%@", error);

		return objects;
	}];
}

@end