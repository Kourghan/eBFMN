//
//  BFMSysAccount+Extension.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 05.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMSysAccount+Extension.h"

#import <FastEasyMapping/FEMMapping.h>

@implementation BFMSysAccount (Extension)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMSysAccount"];
    
    [mapping setPrimaryKey:@"identifier"];
    
    FEMAttribute *attribute = [[FEMAttribute alloc] initWithProperty:@"identifier"
                                                             keyPath:@"AccountNum"
                                                                 map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithInt:[value intValue]];
        }
        return nil;
    } reverseMap:^id(id value) {
        return [value stringValue];
    }];
    [mapping addAttribute:attribute];
    
    [mapping addAttributesFromDictionary:@{
                                           @"balance" : @"Balance",
                                           @"commission" : @"Commission",
                                           @"currency" : @"Currency",
                                           @"managed" : @"Managed",
                                           @"netDeposit" : @"NetDeposit",
                                           @"platform" : @"Platform",
                                           @"platformType" : @"PlatformType",
                                           @"prewNetDeposit" : @"PrewNetDeposit",
                                           @"prewTotalDeposit" : @"PrewTotalDeposit",
                                           @"rebate" : @"Rebate",
                                           @"spread" : @"Spread",
                                           @"totalDeposit" : @"TotalDeposit"
                                           }];
    
    return mapping;
}

@end
