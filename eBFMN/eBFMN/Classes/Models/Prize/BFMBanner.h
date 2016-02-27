//
//  BFMBanner.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "FastEasyMapping.h"

@interface BFMBanner : NSManagedObject

+ (void)bannersWithCompletion:(void (^)(NSArray *banners, NSError *error))completition;

@end

@interface BFMBanner (Mapping)

+ (FEMMapping *)defaultMapping;

@end

#import "BFMBanner+CoreDataProperties.h"
