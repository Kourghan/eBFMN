#import <Foundation/Foundation.h>

@interface ELAAppearance: NSObject

+ (void)applyTo:(id)object;
+ (void)applyToObjects:(NSArray *)objects;

@end