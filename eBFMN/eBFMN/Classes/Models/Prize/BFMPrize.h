//
//  BFMPrize.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFMPrize : NSManagedObject

+ (void)stubInContext:(NSManagedObjectContext *)context;
+ (void)stubIfNeededInContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "BFMPrize+CoreDataProperties.h"
