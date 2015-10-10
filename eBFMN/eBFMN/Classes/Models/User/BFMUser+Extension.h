//
//  BFMUser+Extension.h
//  
//
//  Created by Mikhail Timoscenko on 05.09.15.
//
//

#import "BFMUser.h"

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

@end

@interface BFMUser (Mapping)

+ (FEMMapping *)defaultMapping;

@end