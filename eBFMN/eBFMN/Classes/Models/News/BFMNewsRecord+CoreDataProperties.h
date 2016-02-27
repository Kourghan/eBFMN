//
//  BFMNewsRecord+CoreDataProperties.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 24.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BFMNewsRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMNewsRecord (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *identifier;
@property (nullable, nonatomic, retain) NSString *shortText;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *textIdentifier;
@property (nullable, nonatomic, retain) NSString *text;

@end

NS_ASSUME_NONNULL_END
