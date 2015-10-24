//
//  BFMUser+Extension.h
//  
//
//  Created by Mikhail Timoscenko on 05.09.15.
//
//

#import "BFMUser.h"

typedef enum {
    BFMLeagueTypeSilver = 1,
    BFMLeagueTypeGold = 2,
    BFMLeagueTypePlatinum = 3,
    BFMLeagueTypeDiamand = 4
} BFMLeagueType;

@class FEMMapping;

@interface BFMUser (Entity)

+ (BFMUser *)currentUser;

- (NSNumber *)rebates;
- (NSNumber *)commissions;
- (NSNumber *)spread;

- (NSString *)liveAccountsStringValue;
- (NSString *)demoAccountsStringValue;
- (NSString *)totalAccountsStringValue;
- (NSString *)freshAccountsStringValue;

@end

@interface BFMUser (Accounts)

- (NSArray *)currencies;
- (NSInteger)numberOfCurrencies;
- (NSString *)defaultCurrency;

- (NSString *)rebatesForCurrency:(NSString *)currency;
- (NSString *)commissionsForCurrency:(NSString *)currency;;
- (NSString *)spreadForCurrency:(NSString *)currency;;

@end

@interface BFMUser (Network)

+ (void)getInfoWithCompletitionBlock:(void (^)(BOOL success))completition;
+ (void)getIBLeagues:(void (^)(NSArray *leagues))completition;
+ (void)getAllIBLeagueGoals:(void (^)(NSArray *leagues))completition;
+ (void)getAllIBLeagueBenefits:(void (^)(NSArray *leagues))completition;
+ (void)getIBLeagueBenefitsForType:(BFMLeagueType)type
                   completition:(void (^)(NSArray *leagues))completition;
+ (void)getIBLeagueGoalsForType:(BFMLeagueType)type
                   completition:(void (^)(NSArray *leagues))completition;

@end

@interface BFMUser (Mapping)

+ (FEMMapping *)defaultMapping;

@end