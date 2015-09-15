//
//  BFMTabBarController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/5/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMTabBarController.h"
#import "UIStoryboard+BFMStoryboards.h"

@interface BFMTabBarController ()

@end

@implementation BFMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBarItems];
    self.selectedIndex = 0;
}

- (void)configureTabBarItems {
    UINavigationController *vc1 = [[UIStoryboard dashboardStoryboard] instantiateInitialViewController];
    vc1.tabBarItem.image = [UIImage imageNamed:@"ic_tabBar_dashboard"];
    vc1.tabBarItem.title = NSLocalizedString(@"tabbar.dashboard", nil);
    
    UINavigationController *vc2 = [[UIStoryboard leaderboardStoryboard] instantiateInitialViewController];
    vc2.tabBarItem.image = [UIImage imageNamed:@"ic_tabBar_leaderboard"];
    vc2.tabBarItem.title = @"Leaderboard";
    
    UINavigationController *vc3 = [[UIStoryboard newsStoryboard] instantiateInitialViewController];
    vc3.tabBarItem.image = [UIImage imageNamed:@"ic_tabBar_news"];
    vc3.tabBarItem.title = @"News";
    
    UINavigationController *vc4 = [[UIStoryboard notificationsStoryboard] instantiateInitialViewController];
    vc4.tabBarItem.image = [UIImage imageNamed:@"ic_tabBar_notifications"];
    vc4.tabBarItem.title = @"Notifications";
    
    UINavigationController *vc5 = [[UIStoryboard profileStoryboard] instantiateInitialViewController];
    vc5.tabBarItem.image = [UIImage imageNamed:@"ic_tabBar_profile"];
    vc5.tabBarItem.title = @"Profile";
    
    self.viewControllers = @[vc1, vc2, vc3, vc4, vc5];
}

@end
