//
//  BFMUserCredentials.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMUserCredentials.h"

#import <AFNetworking/AFNetworking.h>
#import "BFMSessionManager.h"

#import "JNKeychain+UNTExtension.h"

typedef enum {
    BFMLoginResultSuccess = 0,
    BFMLoginResultIncorrectLoginOrPassword = 2
} BFMLoginResult;

@implementation BFMUserCredentials

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password {
    if (self = [super init]) {
        _username = username;
        _password = password;
    }
    
    return self;
}

- (void)loginWithCompletitionCompletitionBlock:(void (^)(BOOL success, NSError *error))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];

    [manager GET:@"/API/Accounts/Login"
      parameters:@{@"login" : self.username, @"password" : self.password}
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if ([[responseObject valueForKey:@"State"] integerValue] == BFMLoginResultSuccess) {
                 [JNKeychain saveValue:[responseObject valueForKey:@"Key"] forKey:kBFMSessionKey];
                 if (completition) {
                     completition(YES, nil);
                 }
             } else {
                 if (completition) {
                     completition(NO, nil);
                 }
             }
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         if (completition) {
             completition(NO, error);
         }
     }];
}

@end
