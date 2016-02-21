//
//  BFMSysAccount.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 05.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BFMUser;

@interface BFMSysAccount : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSNumber * commission;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSNumber * managed;
@property (nonatomic, retain) NSNumber * netDeposit;
@property (nonatomic, retain) NSString * platform;
@property (nonatomic, retain) NSNumber * platformType;
@property (nonatomic, retain) NSNumber * prewNetDeposit;
@property (nonatomic, retain) NSNumber * prewTotalDeposit;
@property (nonatomic, retain) NSNumber * rebate;
@property (nonatomic, retain) NSNumber * spread;
@property (nonatomic, retain) NSNumber * totalDeposit;
@property (nonatomic, retain) BFMUser *user;

@end
