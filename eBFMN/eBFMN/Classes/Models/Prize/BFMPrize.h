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

typedef enum {
	BFMPrizeTypeColor = 0,
	BFMPrizeTypeText = 1,
	BFMPrizeTypePlain = 2
} BFMPrizeType;

@interface BFMPrize : NSManagedObject

+ (void)getChildPrizesFrom:(BFMPrize *)prize withCompletion:(void (^)(NSArray *prizes, NSError *error))completition;

+ (void)prizesInCategory:(NSString *)idCategory withCompletion:(void (^)(NSArray *prizes, NSError *error))completition;
+ (void)currentPrizeWithComplatition:(void (^)(BFMPrize *prize, NSError *error))completition;
+ (void)savePrize:(BFMPrize *)prize withCompletition:(void (^)(NSError *error))completition;

+ (void)deleteAllPrizes;

//TODO: get prize by id
+ (void)getPrize:(NSNumber *)identifier
      completion:(void (^)(BFMPrize *prize, NSError *error))completion;

+ (void)prizeTypeById:(NSNumber *)identifier
		   completion:(void (^)(BFMPrizeType type, NSError *error))completion;

@end

@interface BFMPrize (Mapping)

+ (FEMMapping *)defaultMapping;

@end

#import "BFMPrize+CoreDataProperties.h"
