//
//  UIColor+Extensions.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)colorWithR:(uint)r G:(uint)g B:(uint)b A:(uint)a {
    return [self colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f];
}

+ (UIColor *)colorWithR:(uint)r G:(uint)g B:(uint)b {
    return [self colorWithR:r G:g B:b A:255];
}

+ (UIColor *)bfm_defaultNavigationBlue {
    return [self colorWithR:8 G:69 B:110];
}

@end

