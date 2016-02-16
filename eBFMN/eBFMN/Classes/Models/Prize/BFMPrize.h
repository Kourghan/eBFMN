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

+ (void)prizeCategoriesWithCompletion:(void (^)(NSArray *categories, NSError *error))completition;
+ (void)prizesInCategory:(NSString *)idCategory withCompletion:(void (^)(NSArray *prizes, NSError *error))completition;
+ (void)prizeBannerWithCompletion:(void (^)(NSArray *banners, NSError *error))completition;
+ (void)currentPrizeWithComplatition:(void (^)(BFMPrize *prize, NSError *error))completition;
+ (void)savePrize:(BFMPrize *)prize withCompletition:(void (^)(NSError *error))completition;

@end

@interface BFMPrize (Mapping)

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END

#import "BFMPrize+CoreDataProperties.h"
