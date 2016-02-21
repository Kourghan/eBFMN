//
//  BFMSessionManager.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 03.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMSessionManager.h"

static NSString *developmentServerURL = @"http://164.40.131.211:80/API/";
static NSString *productionServerURL = @"";

NSString *const kBFMLogoutNotification= @"kBFMLogoutNotification";

@implementation BFMSessionManager

+ (instancetype)sharedManager {
    static BFMSessionManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BFMSessionManager alloc] initWithBaseURL:[NSURL URLWithString:developmentServerURL]];
    });
    
    return sharedManager;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id object))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    __weak typeof(self) weakSelf = self;
    return [super GET:URLString
           parameters:parameters
              success:^(NSURLSessionDataTask *task, NSDictionary *object) {
                  
                  if (success) {
                      success(task, object);
                  }
                  
                  if ([object isKindOfClass:[NSDictionary class]]) {
                      NSString *key = object[@"Key"];
                      if ([key isEqualToString:@"YouNeedToLogin"]) {
                          [weakSelf postLogoutNotification];
                      }
                  }
              } failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id object))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    __weak typeof(self) weakSelf = self;
    return [super POST:URLString
            parameters:parameters
               success:^(NSURLSessionDataTask *task, NSDictionary *object) {
                   
                   if (success) {
                       success(task, object);
                   }
                   
                   if ([object isKindOfClass:[NSDictionary class]]) {
                       NSString *key = object[@"Key"];
                       if ([key isEqualToString:@"YouNeedToLogin"]) {
                           [weakSelf postLogoutNotification];
                       }
                   }
               } failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id object))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    __weak typeof(self) weakSelf = self;
    return [super PUT:URLString
           parameters:parameters
              success:^(NSURLSessionDataTask *task, NSDictionary *object) {
                  
                  if (success) {
                      success(task, object);
                  }
                  
                  if ([object isKindOfClass:[NSDictionary class]]) {
                      NSString *key = object[@"Key"];
                      if ([key isEqualToString:@"YouNeedToLogin"]) {
                          [weakSelf postLogoutNotification];
                      }
                  }
              } failure:failure];
}

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *task, id object))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    __weak typeof(self) weakSelf = self;
    return [super PATCH:URLString
             parameters:parameters
                success:^(NSURLSessionDataTask *task, NSDictionary *object) {
                    
                    if (success) {
                        success(task, object);
                    }
                    
                    if ([object isKindOfClass:[NSDictionary class]]) {
                        NSString *key = object[@"Key"];
                        if ([key isEqualToString:@"YouNeedToLogin"]) {
                            [weakSelf postLogoutNotification];
                        }
                    }
                } failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id object))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    __weak typeof(self) weakSelf = self;
    return [super DELETE:URLString
              parameters:parameters
                 success:^(NSURLSessionDataTask *task, NSDictionary *object) {
                     
                     if (success) {
                         success(task, object);
                     }
                     
                     if ([object isKindOfClass:[NSDictionary class]]) {
                         NSString *key = object[@"Key"];
                         if ([key isEqualToString:@"YouNeedToLogin"]) {
                             [weakSelf postLogoutNotification];
                         }
                     }
                 } failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                       success:(void (^)(NSURLSessionDataTask * task, id object))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure {
    __weak typeof(self) weakSelf = self;
    return [super POST:URLString
            parameters:parameters
constructingBodyWithBlock:block
               success:^(NSURLSessionDataTask *task, NSDictionary *object) {
                   
                   if (success) {
                       success(task, object);
                   }
                   
                   if ([object isKindOfClass:[NSDictionary class]]) {
                       NSString *key = object[@"Key"];
                       if ([key isEqualToString:@"YouNeedToLogin"]) {
                           [weakSelf postLogoutNotification];
                       }
                   }
               } failure:failure];
}

- (void)postLogoutNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:kBFMLogoutNotification
                          object:nil];
}

@end
