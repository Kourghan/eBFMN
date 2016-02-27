//
//  BFMUtils.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMUtils.h"
#import <UIKit/UIKit.h>

NSString *bfm_webStringFromString(NSString *rawString) {
    NSMutableString *webString = [NSMutableString stringWithString:@""];
    
    NSArray *points = [rawString componentsSeparatedByString:@"\\r\\n"];
    
    if ([points count] > 0) {
        [webString appendString:@"<ul>"];
        for (NSString *point in points) {
            [webString appendString:[NSString stringWithFormat:@"<li>%@</li>", point]];
        }
        [webString appendString:@"</ul>"];
    }
    
    return [webString copy];
};

BOOL sbf_isPhone4() {
    return sbf_matchesSize([UIScreen mainScreen].bounds.size, 320.f, 480.f);
};

BOOL sbf_isPhone5() {
    return sbf_matchesSize([UIScreen mainScreen].bounds.size, 320.f, 568.f);
};

BOOL sbf_isPhone6() {
    return sbf_matchesSize([UIScreen mainScreen].bounds.size, 375.f, 667.f);
};

BOOL sbf_isPhone6P() {
    return sbf_matchesSize([UIScreen mainScreen].bounds.size, 414.f, 736.f);
};

BOOL sbf_matchesSize(CGSize size, CGFloat min, CGFloat max) {
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    return (sbf_feq(MIN(w, h), min)) && (sbf_feq(MAX(w, h), max));
};

BOOL sbf_feq(CGFloat f1, CGFloat f2) {
    return fabs(f1 - f2) < .01f;
};

@implementation BFMUtils

@end
