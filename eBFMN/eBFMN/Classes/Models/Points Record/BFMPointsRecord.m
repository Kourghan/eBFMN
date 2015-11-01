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
    
    [manager GET:@"Bonus/GetSelectedPrize"
      parameters:@{
                   @"guid" : sessionKey
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"]) {
                 completition(nil, [NSError new]);
             } else {
                 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
                 BFMPointsRecord *prize = [FEMDeserializer  objectFromRepresentation:[responseObject valueForKey:@"Data"]
                                                                      mapping:[BFMPointsRecord defaultMapping]
                                                                      context:context];
                 [context MR_saveToPersistentStoreAndWait];
                 completition(prize, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

+ (void)currentPendingBonusData:(void (^)(NSArray * points, NSError * error))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Bonus/GetSelectedPrize"
      parameters:@{
                   @"guid" : sessionKey
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"]) {
                 completition(nil, [NSError new]);
             } else {
                 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
                 BFMPointsRecord *prize = [FEMDeserializer  objectFromRepresentation:[responseObject valueForKey:@"Data"]
                                                                      mapping:[BFMPointsRecord defaultMapping]
                                                                      context:context];
                 [context MR_saveToPersistentStoreAndWait];
                 completition(prize, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

@end
