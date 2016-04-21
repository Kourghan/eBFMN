//
//  BFMTabBarController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/5/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMTabBarController.h"
#import "UIStoryboard+BFMStoryboards.h"
#import "UIColor+Extensions.h"

@interface BFMTabBarController ()

@end

@implementation BFMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBarItems];
    self.selectedIndex = 0;
    
    self.tabBar.tintColor = [UIColor whiteColor];
	
	[[UITabBarItem appearance] setTitleTextAttributes:@{
														NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Regular" size:8.f]
														} forState:UIControlStateNormal];
	[[UITabBarItem appearance] setTitleTextAttributes:@{
														NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Regular" size:8.f]
														} forState:UIControlStateSelected];
}

- (void)configureTabBarItems {
    UINavigationController *vc1 = [[UIStoryboard dashboardStoryboard] instantiateInitialViewController];
    vc1.tabBarItem.image = [[UIImage imageNamed:@"ic_tabBar_dashboard"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabBar_dashboard"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.title = NSLocalizedString(@"tabbar.dashboard", nil);
	[vc1.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -6)];
	
    UINavigationController *vc2 = [[UIStoryboard leaderboardStoryboard] instantiateInitialViewController];
    vc2.tabBarItem.image = [[UIImage imageNamed:@"ic_tabBar_leaderboard"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabBar_leaderboard"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.title = NSLocalizedString(@"tabbar.leaderboard", nil);
	[vc2.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -6)];
    
    UINavigationController *vc3 = [[UIStoryboard newsStoryboard] instantiateInitialViewController];
    vc3.tabBarItem.image = [[UIImage imageNamed:@"ic_tabBar_news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabBar_news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem.title = NSLocalizedString(@"tabbar.news", nil).capitalizedString;
	[vc3.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -6)];

    
//    UINavigationController *vc4 = [[UIStoryboard notificationsStoryboard] instantiateInitialViewController];
//    vc4.tabBarItem.image = [[UIImage imageNamed:@"ic_tabBar_notifications"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabBar_notifications"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc4.tabBarItem.title = @"Notifications";
	
    UINavigationController *vc5 = [[UIStoryboard profileStoryboard] instantiateInitialViewController];
    vc5.tabBarItem.image = [[UIImage imageNamed:@"ic_tabBar_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc5.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabBar_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc5.tabBarItem.title = NSLocalizedString(@"tabbar.profile", nil);
    [vc5.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -6)];
	
    self.viewControllers = @[vc1, vc2, vc3, vc5];
}

@end
