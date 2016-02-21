//
//  BFMUtils.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMUtils.h"

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

@implementation BFMUtils

@end
