//
//  BFMDefaultNavagtionBarAppearance.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMDefaultNavagtionBarAppearance.h"

#import "UIColor+Extensions.h"

@implementation BFMDefaultNavagtionBarAppearance

+ (void)applyTo:(UINavigationBar *)object {
    object.barTintColor = [UIColor bfm_defaultNavigationBlue];
    object.translucent = NO;
    
    object.titleTextAttributes = @{
                                   NSForegroundColorAttributeName: [UIColor whiteColor],
                                   NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Semibold" size:17]
                                   };
}

@end
