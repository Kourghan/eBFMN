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
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

@end
