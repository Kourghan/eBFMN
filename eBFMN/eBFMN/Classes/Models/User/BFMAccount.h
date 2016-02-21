//
//  BFMAccount.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 06.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BFMUser;

@interface BFMAccount : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSNumber * managed;
@property (nonatomic, retain) NSString * platform;
@property (nonatomic, retain) NSNumber * platformType;
@property (nonatomic, retain) BFMUser *user;

@end
