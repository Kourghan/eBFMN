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

@implementation BFMLeaderboardModel

+ (void)getLeaderboardForType:(BFMLeaderboardType)type completition:(void (^)(BOOL))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Reports/GetIBCompetitionResult"
      parameters:@{@"guid" : sessionKey, @"reportType" : @(type)}
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             
             completition(YES);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(NO);
         }];
}

@end
