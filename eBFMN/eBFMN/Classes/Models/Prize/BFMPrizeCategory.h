//
//  BFMPrizeCategory.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FastEasyMapping.h"

@interface BFMPrizeCategory : NSManagedObject

+ (void)prizeCategoriesWithCompletion:(void (^)(NSArray *categories, NSError *error))completition;

@end

@interface BFMPrizeCategory (Mapping)

+ (FEMMapping *)defaultMapping;

@end

#import "BFMPrizeCategory+CoreDataProperties.h"
