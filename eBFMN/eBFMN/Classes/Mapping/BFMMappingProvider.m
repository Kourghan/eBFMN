//
//  BFMMappingProvider.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 03.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMMappingProvider.h"
#import "BFMUser+Extension.h"

@implementation BFMMappingProvider

+ (FEMMapping *)userInfoMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMUser" rootPath:@"Data"];

    [mapping setPrimaryKey:@"identifier"];
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"ID",
                                           @"name" : @"Name",
                                           @"accCount" : @"AccCount",
                                           @"code" : @"Code",
                                           @"type" : @"Type",
                                           @"ibsCount" : @"IbsCount",
                                           @"groupType" : @"GroupType",
                                           @"main" : @"isMainOffice"
                                           }];

    return mapping;
}

@end
