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

- (NSString *)balanceString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setPaddingPosition:NSNumberFormatterPadAfterSuffix];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    [formatter setDecimalSeparator:@"."];
    
    return [formatter stringFromNumber:self.balance];
}

@end
