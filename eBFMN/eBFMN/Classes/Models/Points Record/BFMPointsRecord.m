//
//  BFMPointsRecord.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPointsRecord.h"
#import "JNKeychain+UNTExtension.h"
#import "BFMSessionManager.h"

#import <MagicalRecord/MagicalRecord.h>
#import <FastEasyMapping/FEMDeserializer.h>

@implementation BFMPointsRecord

+ (void)pendingBonusDataHistory:(void (^)(NSArray * points, NSError * error))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Bonus/GetPendingBonusDataHistory"
      parameters:@{
                   @"guid" : sessionKey,
                   @"from" : @(0),
                   @"to" : [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]],
                   @"countRowsTable" : @INT32_MAX,
                   @"page" : @(0)
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"]) {
                 completition(nil, [NSError new]);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

+ (void)currentPendingBonusData:(void (^)(NSArray * points, NSError * error))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Bonus/GetCurrentPendingBonusData"
      parameters:@{
                   @"guid" : sessionKey
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"]) {
                 completition(nil, [NSError new]);
             } else {
                 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
                 NSArray *transactions = [FEMDeserializer  collectionFromRepresentation:[responseObject valueForKey:@"Data"]
                                                                                mapping:[BFMPointsRecord defaultMapping]
                                                                                context:context];
                 [context MR_saveToPersistentStoreAndWait];
                 completition(transactions, nil);

             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMPointsRecord"];
    
    [mapping setPrimaryKey:@"identifier"];
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"Id",
                                           @"type" : @"type",
                                           @"points" : @"Points",
                                           @"deposit" : @"Deposit",
                                           @"requiredLots" : @"RequiredLots"
                                           }
     ];
    
    FEMAttribute *attribute = [[FEMAttribute alloc] initWithProperty:@"expirationDate"
                                                             keyPath:@"ExpirationDate"
                                                                 map:^id(id value) {
                                                                     if ([value isKindOfClass:[NSString class]]) {
                                                                         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                         [formatter setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss"];
                                                                         return [formatter dateFromString:value];
                                                                     }
                                                                     return nil;
                                                                 } reverseMap:^id(id value) {
                                                                     return [value stringValue];
                                                                 }];
    [mapping addAttribute:attribute];

    
    return mapping;
}

- (NSDate *)dayStartDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    NSCalendarUnit unit = NSCalendarUnitYear
    | NSCalendarUnitMonth
    | NSCalendarUnitDay;
    NSDateComponents *dateComps = [calendar components:unit
                                              fromDate:self.expirationDate];
    
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    return [calendar dateFromComponents:dateComps];
}

@end
