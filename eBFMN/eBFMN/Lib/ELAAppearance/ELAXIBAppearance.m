#import "ELAXIBAppearance.h"

@implementation ELAXIBAppearance

@dynamic objects;

#pragma mark - Properties

- (void)setObjects:(NSArray *)objects {
    [self.class applyToObjects:objects];
}

- (NSArray *)objects {
	return nil;
}

@end