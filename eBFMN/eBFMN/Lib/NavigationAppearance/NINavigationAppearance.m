#import "NINavigationAppearance.h"

@interface NINavigationAppearanceSnapshot : NSObject

@property (nonatomic, strong, readonly) NSDictionary *snapshot;
@property (nonatomic, strong, readonly) UIImage *backgroundImage;

@property (nonatomic, readonly, assign) UIStatusBarStyle statusBarStyle;

- (id)initForNavigationController:(UINavigationController *)navigationController;

- (void)restoreForNavigationController:(UINavigationController *)navigationController;

@end


@implementation NINavigationAppearanceSnapshot

- (id)initForNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _snapshot = [navigationController.navigationBar dictionaryWithValuesForKeys:@[
            @"barStyle",
            @"translucent",
            @"tintColor",
            @"barTintColor",
            @"titleTextAttributes",
            @"backgroundColor"
        ]];

        _backgroundImage = [navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
        _statusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    }

    return self;
}

- (void)restoreForNavigationController:(UINavigationController *)navigationController {
    [navigationController.navigationBar setValuesForKeysWithDictionary:self.snapshot];
    [navigationController.navigationBar setBackgroundImage:self.backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle animated:YES];
}

@end

@implementation NINavigationAppearance

static NSMutableArray *stack = nil;
+ (void)pushAppearanceForNavigationController:(UINavigationController *)navigationController {
    if (!stack) {
        stack = [[NSMutableArray alloc] init];
    }

    NINavigationAppearanceSnapshot *snapshot = [[NINavigationAppearanceSnapshot alloc] initForNavigationController:navigationController];
    [stack addObject:snapshot];
}

+ (void)popAppearanceForNavigationController:(UINavigationController *)navigationController {
    if ([stack count]) {
        NINavigationAppearanceSnapshot *snapshot = stack[0];
        [snapshot restoreForNavigationController:navigationController];
        [stack removeObject:snapshot];
    }

    if (![stack count]) {
        stack = nil;
    }
}

+ (NSInteger)count {
    return [stack count];
}

+ (void)clear {
    [stack removeAllObjects];
    stack = nil;
}

@end
