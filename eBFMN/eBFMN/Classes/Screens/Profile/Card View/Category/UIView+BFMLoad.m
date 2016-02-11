//
//  UIView+BFMLoad.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "UIView+BFMLoad.h"

@implementation UIView (BFMLoad)

+ (instancetype)bfm_load {
    NSString *name = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *objects = [bundle loadNibNamed:name owner:nil options:nil];
    return objects.firstObject;
}

@end
