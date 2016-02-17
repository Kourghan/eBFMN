//
//  BFMPrizeCategory+CoreDataProperties.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BFMPrizeCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMPrizeCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
