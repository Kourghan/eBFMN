//
//  BFMUserCredentials.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMUserCredentials.h"

#import <AFNetworking/AFNetworking.h>

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

- (void)loginWithCompletition {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://164.40.131.211:80"]];

    [manager GET:@"/API/Accounts/Login" parameters:@{@"login" : self.username, @"password" : self.password} success:^(NSURLSessionDataTask *task, id responseObject)
     {
         // Success
         NSLog(@"Success: %@", responseObject);
     }failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         // Failure
         NSLog(@"Failure: %@", error);
     }];
}

@end
