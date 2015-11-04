//
//  BFMNewsRecord.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 14.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FEMMapping;

@interface BFMNewsRecord : NSManagedObject

+ (void)getNewsFromDate:(NSInteger)date withCompletition:(void (^)(NSArray *prizes, NSError *error))completition;

+ (NSInteger)unixLatestNewsDate;

@end

@interface BFMNewsRecord (Mapping)

+ (FEMMapping *)defaultMapping;

@end

#import "BFMNewsRecord+CoreDataProperties.h"
