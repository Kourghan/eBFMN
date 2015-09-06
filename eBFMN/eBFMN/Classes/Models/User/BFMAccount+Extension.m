//
//  BFMAccount+Extension.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 06.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMAccount+Extension.h"

#import <FastEasyMapping/FEMMapping.h>

@implementation BFMAccount (Extension)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMAccount"];
    
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
                                           @"currency" : @"Currency",
                                           @"managed" : @"Managed",
                                           @"platform" : @"Platform",
                                           @"platformType" : @"PlatformType"
                                           }];
    
    return mapping;
}

@end
