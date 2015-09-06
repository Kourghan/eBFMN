#import "ELAAppearance.h"

@implementation ELAAppearance

#pragma mark - Theme

+ (void)applyTo:(id)object {
	[NSException raise:@"SubsclassException" format:@"Subclass should override method: %@", NSStringFromSelector(_cmd)];
}

+ (void)applyToObjects:(NSArray *)objects {
    for (id object in objects) {
        [self applyTo:object];
    }
}

@end