//
//  BFMUser.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BFMAccount, BFMSysAccount;

@interface BFMUser : NSManagedObject

@property (nonatomic, retain) NSNumber * accCountDemo;
@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSNumber * groupType;
@property (nonatomic, retain) NSNumber * ibsCount;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * main;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * accCountLive;
@property (nonatomic, retain) NSSet *accounts;
@property (nonatomic, retain) NSSet *sysAccounts;
@end

@interface BFMUser (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(BFMAccount *)value;
- (void)removeAccountsObject:(BFMAccount *)value;
- (void)addAccounts:(NSSet *)values;
- (void)removeAccounts:(NSSet *)values;

- (void)addSysAccountsObject:(BFMSysAccount *)value;
- (void)removeSysAccountsObject:(BFMSysAccount *)value;
- (void)addSysAccounts:(NSSet *)values;
- (void)removeSysAccounts:(NSSet *)values;

@end
