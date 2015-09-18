//
//  BFMLeaderboardModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 06.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    BFMLeaderboardTypePoints = 0,
    BFMLeaderboardTypeRebate = 1,
    BFMLeaderboardTypeVolume = 2,
    BFMLeaderboardTypePL = 3
}; typedef NSUInteger BFMLeaderboardType;

@interface BFMLeaderboardModel : NSObject

+ (void)getLeaderboardForType:(BFMLeaderboardType)type success:(void (^)(NSArray *))successBlock failure:(void (^)(NSError *))failureBlock;

@end
