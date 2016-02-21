//
//  BFMUser+CoreDataProperties.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BFMUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFMUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *accCountDemo;
@property (nullable, nonatomic, retain) NSNumber *accCountLive;
@property (nullable, nonatomic, retain) NSNumber *code;
@property (nullable, nonatomic, retain) NSNumber *groupType;
@property (nullable, nonatomic, retain) NSNumber *ibsCount;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSNumber *main;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *currentCurrency;
@property (nullable, nonatomic, retain) NSSet<BFMAccount *> *accounts;
@property (nullable, nonatomic, retain) NSSet<BFMSysAccount *> *sysAccounts;

@end

@interface BFMUser (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(BFMAccount *)value;
- (void)removeAccountsObject:(BFMAccount *)value;
- (void)addAccounts:(NSSet<BFMAccount *> *)values;
- (void)removeAccounts:(NSSet<BFMAccount *> *)values;

- (void)addSysAccountsObject:(BFMSysAccount *)value;
- (void)removeSysAccountsObject:(BFMSysAccount *)value;
- (void)addSysAccounts:(NSSet<BFMSysAccount *> *)values;
- (void)removeSysAccounts:(NSSet<BFMSysAccount *> *)values;

@end

NS_ASSUME_NONNULL_END
