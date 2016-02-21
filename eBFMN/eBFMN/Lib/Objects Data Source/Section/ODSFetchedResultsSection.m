
#import "ODSFetchedResultsSection.h"

@import CoreData;

@implementation ODSFetchedResultsSection {
	id<NSFetchedResultsSectionInfo> _sectionInfo;
}

#pragma mark - Init

- (instancetype)initWithSectionInfo:(id<NSFetchedResultsSectionInfo>)sectionInfo {
	NSParameterAssert(sectionInfo);

    self = [super init];
    if (self) {
        _sectionInfo = sectionInfo;
    }

	return self;
}

#pragma mark - Access

- (NSString *)name {
    return _sectionInfo.name;
}

- (NSUInteger)numberOfObjects {
    return _sectionInfo.numberOfObjects;
}

- (NSArray *)objects {
    return _sectionInfo.objects;
}

@end