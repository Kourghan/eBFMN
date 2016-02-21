//
//  BFMLeaderboardRecord+Mapping.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/18/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMLeaderboardRecord+Mapping.h"
#import <FastEasyMapping/FastEasyMapping.h>

@implementation BFMLeaderboardRecord (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[BFMLeaderboardRecord class]];
    mapping.primaryKey = @"groupID";
    
    
    [mapping addAttributesFromDictionary:@{
                                           @"groupID" : @"groupID",
                                           @"groupName" : @"groupName",
                                           @"date" : @"date",
                                           @"value" : @"value",
                                           }];
    
    return mapping;
}

@end
