//
//  BFMPrize+CoreDataProperties.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 29.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BFMPrize.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMPrize (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *iconURL;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *points;
@property (nullable, nonatomic, retain) NSNumber *prizeType;
@property (nullable, nonatomic, retain) NSNumber *oldPoints;
@property (nullable, nonatomic, retain) NSNumber *categoryId;
@property (nullable, nonatomic, retain) NSString *summary;

@end

NS_ASSUME_NONNULL_END
