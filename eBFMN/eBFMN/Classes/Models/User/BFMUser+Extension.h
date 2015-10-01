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

- (NSNumber *)rebatesForCurrency:(NSString *)currency;
- (NSNumber *)commissionsForCurrency:(NSString *)currency;;
- (NSNumber *)spreadForCurrency:(NSString *)currency;;

@end

@interface BFMUser (Network)

+ (void)getInfoWithCompletitionBlock:(void (^)(BOOL success))completition;

@end

@interface BFMUser (Mapping)

+ (FEMMapping *)defaultMapping;

@end