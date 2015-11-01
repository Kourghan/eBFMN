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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MagicalRecord setupAutoMigratingCoreDataStack];

    UINavigationController *controller;
    if ([JNKeychain loadValueForKey:kBFMSessionKey]) {
        controller = [UIStoryboard storyboardWithName:@"tabBar" bundle:nil].instantiateInitialViewController;
    } else {
        controller = [UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
    }

    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

@end
