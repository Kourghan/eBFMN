//
//  BFMPointsRecord+CoreDataProperties.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BFMPointsRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMPointsRecord (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *identifier;

@end

NS_ASSUME_NONNULL_END
