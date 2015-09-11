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

+ (BFMUser *)stubUser;

@end

@interface BFMUser (Network)

+ (void)getInfoWithCompletitionBlock:(void (^)(BOOL success))completition;

@end

@interface BFMUser (Mapping)

+ (FEMMapping *)defaultMapping;

@end