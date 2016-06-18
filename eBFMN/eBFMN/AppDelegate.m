//
//  AppDelegate.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>

#import "BFMUser+Extension.h"

#import "JNKeychain+UNTExtension.h"

#import "UIColor+Extensions.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Fabric with:@[[Crashlytics class]]];
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    [MagicalRecord setupAutoMigratingCoreDataStack];

    UINavigationController *controller;
    if ([JNKeychain loadValueForKey:kBFMSessionKey]) {
        controller = [UIStoryboard storyboardWithName:@"tabBar" bundle:nil].instantiateInitialViewController;
    } else {
        controller = [UIStoryboard storyboardWithName:@"NewLogin" bundle:nil].instantiateInitialViewController;
    }

    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
//    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
	
	
	
	[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"ic_hover"]];
	[[UITabBar appearance] setTranslucent:NO];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

- (void)showHome {
    [self showVC:[UIStoryboard storyboardWithName:@"tabBar" bundle:nil].instantiateInitialViewController];
}

- (void)showLogin {
    [self showVC:[UIStoryboard storyboardWithName:@"NewLogin" bundle:nil].instantiateInitialViewController];
}

- (void)showVC:(UIViewController *)vc {
    [vc view];
    vc.view.frame = [UIScreen mainScreen].bounds;
    [UIView transitionFromView:self.window.subviews.lastObject
                        toView:vc.view
                      duration:.6
                       options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionFlipFromLeft)
                    completion:^(BOOL finished) {
                        self.window.rootViewController = vc;
                    }];
}

@end
