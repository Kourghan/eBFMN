
#import "ODSArraySection.h"

@interface ODSArraySection ()

@property (nonatomic, strong) NSMutableArray *mutableObjects;

@end

@implementation ODSArraySection

#pragma mark - Init

- (instancetype)initWithObjects:(NSArray *)objects {
	self = [super init];
	if (self) {
		[self setObjects:objects];
	}

	return self;
}

+ (instancetype)sectionWithObjects:(NSArray *)objects {
	// to silence compiler warning. he thinks, that i need to put nil in the end
	return [(ODSArraySection *)[self alloc] initWithObjects:objects];
}

#pragma mark - Access

- (NSUInteger)numberOfObjects {
	return _mutableObjects.count;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
	// to silence compiler warning. he thinks, that i need to put nil in the end
	ODSArraySection *copy = [(ODSArraySection *)[self.class alloc] initWithObjects:_mutableObjects];

	[copy setTag:self.tag];

	return copy;
}

- (void)setObjects:(NSArray *)objects {
	[self setMutableObjects:[objects mutableCopy]];
}

- (NSArray *)objects {
	return _mutableObjects;
}

@end