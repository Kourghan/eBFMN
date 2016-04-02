//
//  BFMPointsRecord+CoreDataProperties.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 31.03.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BFMPointsRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMPointsRecord (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *deposit;
@property (nullable, nonatomic, retain) NSDate *expirationDate;
@property (nullable, nonatomic, retain) NSString *identifier;
@property (nullable, nonatomic, retain) NSNumber *points;
@property (nullable, nonatomic, retain) NSNumber *requiredLots;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSNumber *benefit;
@property (nullable, nonatomic, retain) NSNumber *ibid;
@property (nullable, nonatomic, retain) NSNumber *lotsCount;

@end

NS_ASSUME_NONNULL_END
