//
//  BFMPointsRecord.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FEMMapping;

NS_ASSUME_NONNULL_BEGIN

@interface BFMPointsRecord : NSManagedObject

+ (void)currentPendingBonusData:(void (^)(NSArray *points, NSError *error))completition;
+ (void)pendingBonusDataHistory:(void (^)(NSArray *points, NSError *error))completition;

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END

#import "BFMPointsRecord+CoreDataProperties.h"
