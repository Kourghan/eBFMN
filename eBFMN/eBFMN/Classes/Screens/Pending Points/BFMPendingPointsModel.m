//
//  BFMPendingPointsModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPendingPointsModel.h"
#import "BFMPointsRecord.h"

@implementation BFMPendingPointsModel

- (NSString *)title {
    return NSLocalizedString(@"points.title", nil);
}

- (void)loadDataWithCallback:(void (^)(NSError *))callback {
    __weak typeof(self) weakSelf = self;
    
    [BFMPointsRecord pendingBonusDataHistory:^(NSArray *points, NSError *error) {
        if (!error) {
            callback(nil);
        } else {
            callback(error);
        }
    }];
    
//    [BFMPointsRecord currentPendingBonusData:^(NSArray *points, NSError *error) {
//        if (!error) {
//            [BFMPointsRecord pendingBonusDataHistory:^(NSArray *points, NSError *error) {
//                if (!error) {
//                    callback(nil);
//                } else {
//                    callback(error);
//                }
//            }];
//        } else {
//            callback(error);
//        }
//    }];
}

@end
