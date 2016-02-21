//
//  BFMLeaderboardModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 06.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMLeaderboardModel.h"

#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"
#import "BFMLeaderboardRecord+Mapping.h"
#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation BFMLeaderboardModel

+ (void)getLeaderboardForType:(BFMLeaderboardType)type success:(void (^)(NSArray *records))successBlock failure:(void (^)(NSError *error))failureBlock {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Reports/GetIBCompetitionResult"
      parameters:@{@"guid" : sessionKey, @"reportType" : @(type)}
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            // NSLog(@"Response: %@", responseObject);
             NSArray *records =  [FEMDeserializer collectionFromRepresentation:[responseObject objectForKey:@"Data"] mapping:[BFMLeaderboardRecord defaultMapping]];
            // NSLog(@"Records: %@", records);
             successBlock(records);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             failureBlock(error);
         }];
}

@end
