//
//  BFMSessionManager.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 03.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface BFMSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
