//
//  BFMUser+Extension.h
//  
//
//  Created by Mikhail Timoscenko on 05.09.15.
//
//

#import "BFMUser.h"

typedef enum {
    BFMLeagueTypeUndefined = 0,
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

- (void)getIBLeagueWithCompletitionBlock:(void (^)(BFMLeagueType type, NSError *error))completition;

+ (void)getInfoWithCompletitionBlock:(void (^)(BOOL success))completition;
+ (void)getIBLeagues:(void (^)(NSArray *leagues))completition;
+ (void)getAllIBLeagueGoals:(void (^)(NSDictionary *leagues, NSError *error))completition;
+ (void)getAllIBLeagueBenefits:(void (^)(NSDictionary *leagues, NSError *error))completition;
+ (void)getIBLeagueBenefitsForType:(BFMLeagueType)type
                   completition:(void (^)(NSArray *leagues))completition;
+ (void)getIBLeagueGoalsForType:(BFMLeagueType)type
                   completition:(void (^)(NSArray *leagues))completition;

+ (void)getLinkForOffice:(void (^)(NSString * link, NSError *error))completition;

@end

@interface BFMUser (Mapping)

+ (FEMMapping *)defaultMapping;

@end