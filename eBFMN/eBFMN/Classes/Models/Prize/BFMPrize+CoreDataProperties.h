//
//  BFMPrize+CoreDataProperties.h
//  
//
//  Created by Mikhail Timoscenko on 31.10.15.
//
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

@end

NS_ASSUME_NONNULL_END
