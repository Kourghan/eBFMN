//
//  BFMNewsRecord.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 14.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsRecord.h"

#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMNewsRecord

+ (void)getNewsFromDate:(NSInteger)date withCompletition:(void (^)(NSArray *, NSError *))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    NSDictionary *params = @{@"guid" : sessionKey, @"from" : @(date)};
    [manager GET:@"Reports/GetNews"
      parameters:params
         success:^(NSURLSessionDataTask *task, NSArray *responseObject) {
             if (![responseObject isEqual: @[]]) {
                 NSManagedObjectContext *ctx = [NSManagedObjectContext MR_defaultContext];
                 NSArray *records = [FEMDeserializer collectionFromRepresentation:responseObject
                                                                          mapping:[BFMNewsRecord defaultMapping]
                                                                          context:ctx];
                 [ctx MR_saveToPersistentStoreAndWait];
                 completition(records, nil);
             } else {
                 completition(nil, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }];
}

+ (NSInteger)unixLatestNewsDate {
    NSArray *news = [BFMNewsRecord MR_findAllSortedBy:@"date" ascending:NO];
    if ([news count] > 0) {
        BFMNewsRecord *latesNews = [news firstObject];
        NSInteger timestamp = [latesNews.date timeIntervalSince1970];
        return timestamp;
    } else {
        return 1446336000;
    }
}

@end

@implementation BFMNewsRecord (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMNewsRecord"];
    mapping.primaryKey = @"identifier";
    
    
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"_id",
                                           @"title" : @"Title",
                                           @"shortText" : @"ShortText"
                                           }];
    
    FEMAttribute *attribute = [[FEMAttribute alloc] initWithProperty:@"date"
                                                             keyPath:@"Date"
                                                                 map:^id(id value) {
                                                                     if ([value isKindOfClass:[NSString class]]) {
                                                                         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                         [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                                                                         return [formatter dateFromString:value];
                                                                     }
                                                                     return nil;
                                                                 } reverseMap:^id(id value) {
                                                                     return [value stringValue];
                                                                 }];
    [mapping addAttribute:attribute];

    
    return mapping;
}

@end