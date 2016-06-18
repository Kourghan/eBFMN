//
//  BFMSignUpCountry.m
//  
//
//  Created by Mykyta Shytik on 6/18/16.
//
//

#import "BFMSignUpCountry.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation BFMSignUpCountry

+ (NSArray *)objectsFromResponse:(NSDictionary *)response {
    NSArray *data = response[@"Data"];
    
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:data.count];
    
    for (NSDictionary *dict in data) {
        @autoreleasepool {
            BFMSignUpCountry *country = [BFMSignUpCountry objectFromResponse:dict];
            [objects addObject:country];
        }
    }
    
    return objects.copy;
}

+ (instancetype)objectFromResponse:(NSDictionary *)response {
    BFMSignUpCountry *country = [self new];
    [country parseField:@"identifier" dict:response key:@"Id"];
    [country parseField:@"code" dict:response key:@"Code"];
    [country parseField:@"ISOCode" dict:response key:@"ISOCode"];
    [country parseField:@"companyID" dict:response key:@"CompanyID"];
    [country parseField:@"name" dict:response key:@"Name"];
    return country;
}

- (void)parseField:(NSString *)field dict:(NSDictionary *)dict key:(NSString *)key {
    id result = nil;
    id value = dict[key];
    
    if ([value isKindOfClass:[NSString class]]) {
        result = value;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        result = [value stringValue];
    }
    
    [self setValue:result forKey:field];
}

@end
