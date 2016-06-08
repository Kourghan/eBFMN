//
//  BFMPointsRecord.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    BFMTransactionTypeNotStared = 0,
    BFMTransactionTypeInProgress = 4,
    BFMTransactionTypeExpired = 5,
    BFMTransactionTypeCompleted = 6
} BFMTransactionType;

@class FEMMapping;

NS_ASSUME_NONNULL_BEGIN

@interface BFMPointsRecord : NSManagedObject

+ (void)currentPendingBonusData:(void (^)(NSArray *points, NSError *error))completition;
+ (void)pendingBonusDataHistoryFromDate:(NSDate *)dateFrom
                                 toDate:(NSDate *)dateTo
                           completition:(void (^)(NSArray *points, NSError *error))completition;

+ (FEMMapping *)defaultMapping;
+ (FEMMapping *)historyMapping;
- (NSDate *)dayStartDate;

@end

NS_ASSUME_NONNULL_END

#import "BFMPointsRecord+CoreDataProperties.h"
