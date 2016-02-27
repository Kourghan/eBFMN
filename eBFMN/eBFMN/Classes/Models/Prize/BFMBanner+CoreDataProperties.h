//
//  BFMBanner+CoreDataProperties.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BFMBanner.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMBanner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSNumber *prizeId;

@end

NS_ASSUME_NONNULL_END
