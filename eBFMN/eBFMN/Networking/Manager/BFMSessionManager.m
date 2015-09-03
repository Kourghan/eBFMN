//
//  BFMSessionManager.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 03.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMSessionManager.h"

static NSString *developmentServerURL = @"http://164.40.131.211:80";
static NSString *productionServerURL = @"";

@implementation BFMSessionManager

+ (instancetype)sharedManager {
    static BFMSessionManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BFMSessionManager alloc] initWithBaseURL:[NSURL URLWithString:developmentServerURL]];
    });
    
    return sharedManager;
}

@end
