//
//  BFMUserCredentials.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMUserCredentials : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

- (void)loginWithCompletitionCompletitionBlock:(void (^)(BOOL success, NSError *error))completition;

@end
