//
//  BFMSessionManager.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 03.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef enum {
    BFMNetworkStateSuccess = 0,
    BFMNetworkStateFailed = 1
} BFMNetworkState;

extern NSString *const kBFMLogoutNotification;

@interface BFMSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
