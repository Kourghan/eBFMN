
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NINavigationAppearance : NSObject

+ (void)pushAppearanceForNavigationController:(UINavigationController *)navigationController;

+ (void)popAppearanceForNavigationController:(UINavigationController *)navigationController;

+ (NSInteger)count;
+ (void)clear;

@end
