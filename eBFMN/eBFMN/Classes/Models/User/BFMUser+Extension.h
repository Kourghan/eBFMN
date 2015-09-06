//
//  BFMUser+Extension.h
//  
//
//  Created by Mikhail Timoscenko on 05.09.15.
//
//

#import "BFMUser.h"

@class FEMMapping;

@interface BFMUser (Extension)

+ (void)getInfoWithCompletitionBlock:(void (^)(BOOL success))completition;

+ (FEMMapping *)defaultMapping;

@end
