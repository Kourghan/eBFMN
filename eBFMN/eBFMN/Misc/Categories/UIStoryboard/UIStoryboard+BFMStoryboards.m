//
//  UIStoryboard+BFMStoryboards.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/5/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "UIStoryboard+BFMStoryboards.h"

@implementation UIStoryboard (BFMStoryboards)

+ (UIStoryboard *)dashboardStoryboard {
    return [UIStoryboard storyboardWithName:@"Dashboard" bundle:nil];
}

+ (UIStoryboard *)leaderboardStoryboard {
    return [UIStoryboard storyboardWithName:@"Leaderboard" bundle:nil];
}

+ (UIStoryboard *)newsStoryboard {
    return [UIStoryboard storyboardWithName:@"News" bundle:nil];
}

+ (UIStoryboard *)notificationsStoryboard {
    return [UIStoryboard storyboardWithName:@"Notifications" bundle:nil];
}

+ (UIStoryboard *)profileStoryboard {
    return [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
}

+ (UIStoryboard *)tabBarStoryboard {
    return [UIStoryboard storyboardWithName:@"tabBar" bundle:nil];
}

@end
