//
//  UIColor+Extensions.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)colorWithR:(uint)r G:(uint)g B:(uint)b A:(uint)a;
+ (UIColor *)colorWithR:(uint)r G:(uint)g B:(uint)b;

+ (UIColor *)bfm_defaultNavigationBlue;

@end

@interface UIColor (Text)

+ (UIColor *)bfm_lightGrayColor;
+ (UIColor *)bfm_darkBlueColor;

@end
