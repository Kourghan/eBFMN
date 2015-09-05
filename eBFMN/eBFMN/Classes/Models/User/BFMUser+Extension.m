//
//  BFMUser+Extension.m
//  
//
//  Created by Mikhail Timoscenko on 05.09.15.
//
//

#import "BFMUser+Extension.h"

#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"
#import "BFMMappingProvider.h"
#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMUser (Extension)

+ (void)getInfoWithCompletitionBlock:(void (^)(BOOL success))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Accounts/GetInfo"
      parameters:@{@"guid" : sessionKey, @"userLogin" : @"-1"}
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
             [FEMManagedObjectDeserializer objectFromRepresentation:responseObject
                                                            mapping:[BFMMappingProvider userInfoMapping]
                                                            context:context];
             completition(YES);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(NO);
         }];
}

@end
