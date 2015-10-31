//
//  BFMNewsRecord+Mapping.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 10/26/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMNewsRecord+Mapping.h"
#import <FastEasyMapping/FastEasyMapping.h>

@implementation BFMNewsRecord (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[BFMNewsRecord class]];
    mapping.primaryKey = @"identifier";
    
    
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"identifier",
                                           @"title" : @"title",
                                           @"text" : @"text",
                                           @"date" : @"date",
                                           }];
    
    return mapping;
}

@end
