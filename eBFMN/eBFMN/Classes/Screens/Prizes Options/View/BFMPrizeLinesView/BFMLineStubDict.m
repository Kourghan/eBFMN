//
//  BFMLineStubDict.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMLineStubDict.h"

#import <UIKit/UIKit.h>

@implementation BFMLineStubDict

- (UIColor *)bfm_color {
    return [UIColor colorWithRed:6.f/255.f
                           green:69.f/255.f
                            blue:109.f/255.f
                           alpha:1.f];
}

- (NSString *)bfm_title {
    return self.title;
}
- (BOOL)bfm_isFill {
    return YES;
}

+ (instancetype)withTitle:(NSString *)title {
    BFMLineStubDict *dict = [self new];
    dict.title = title;
    return dict;
}

+ (NSArray *)stubs {
    return @[
             
             [self withTitle:@"Silver"],
             [self withTitle:@"Gold"],
             [self withTitle:@"Space Gray"],
             [self withTitle:@"Rose Gold"],
             ];
}

+ (NSArray *)stubs2 {
    return @[
             
             [self withTitle:@"16GB"],
             [self withTitle:@"32GB"],
             [self withTitle:@"64GB"],
             
             ];
}

@end
