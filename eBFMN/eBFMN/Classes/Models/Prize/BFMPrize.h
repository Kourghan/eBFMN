//
//  BFMPrize.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import <FastEasyMapping/FastEasyMapping.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFMPrize : NSManagedObject

+ (void)prizesWithCompletition:(void (^)(NSArray *prizes, NSError *error))completition;
+ (void)currentPrizeWithComplatition:(void (^)(BFMPrize *prize, NSError *error))completition;
+ (void)savePrize:(BFMPrize *)prize withCompletition:(void (^)(NSArray *prizes, NSError *error))completition;

@end

@interface BFMPrize (Mapping)

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END

#import "BFMPrize+CoreDataProperties.h"
