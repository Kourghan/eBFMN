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
#import "BFMSysAccount+Extension.h"
#import "BFMAccount+Extension.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMUser (Entity)

+ (BFMUser *)currentUser {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    return [BFMUser MR_findFirstInContext:context];
}

- (NSNumber *)rebates {
    double rebates = 0.f;
    for (BFMSysAccount *sysAcc in self.sysAccounts) {
        rebates += [sysAcc.rebate doubleValue];
    }
    
    return [NSNumber numberWithDouble:rebates];
}

- (NSNumber *)commissions {
    double commission = 0.f;
    for (BFMSysAccount *sysAcc in self.sysAccounts) {
        commission += [sysAcc.commission doubleValue];
    }
    
    return [NSNumber numberWithDouble:commission];
}

- (NSNumber *)spread {
    double spread = 0.f;
    for (BFMSysAccount *sysAcc in self.sysAccounts) {
        spread += [sysAcc.spread doubleValue];
    }
    
    return [NSNumber numberWithDouble:spread];
}

- (NSString *)demoAccountsStringValue {
    if ([self.accCountDemo intValue] > 999) {
        return @"999+";
    } else {
        return [self.accCountDemo stringValue];
    }
}

- (NSString *)liveAccountsStringValue {
    if ([self.accCountLive intValue] > 999) {
        return @"999+";
    } else {
        return [self.accCountLive stringValue];
    }
}

- (NSString *)totalAccountsStringValue {
    int totalAccounts = [self.accCountLive intValue] + [self.accCountDemo intValue];
    if (totalAccounts > 999) {
        return @"999+";
    } else {
        return [NSString stringWithFormat:@"%i", totalAccounts];
    }
}

- (NSString *)freshAccountsStringValue {
    return @"0";
}

@end

@implementation BFMUser (Network)

+ (void)getInfoWithCompletitionBlock:(void (^)(BOOL success))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Accounts/GetInfo"
      parameters:@{@"guid" : sessionKey, @"userLogin" : @"-1"}
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];

             // Workaround for server responce logic (dynamic keys in dictionary)
             
             NSMutableDictionary *rawData = [[responseObject valueForKey:@"Data"] mutableCopy];
             NSDictionary *rawAccounts = [rawData valueForKey:@"accounts"];
             NSMutableDictionary *response = [responseObject mutableCopy];
             
             if (rawAccounts != nil) {
                 
                 NSMutableArray *accounts = [NSMutableArray array];
                 
                 for (NSString *key in [rawAccounts allKeys]) {
                     [accounts addObjectsFromArray:[rawAccounts valueForKey:key]];
                 }
                 
                 [rawData setValue:accounts forKey:@"accounts"];
                 [response setValue:rawData forKey:@"Data"];
             }
             
             [FEMManagedObjectDeserializer objectFromRepresentation:[response copy]
                                                            mapping:[BFMUser defaultMapping]
                                                            context:context];
             
             [context MR_saveToPersistentStoreAndWait];
             completition(YES);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(NO);
         }];
}

@end

@implementation BFMUser (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMUser" rootPath:@"Data"];
    
    [mapping setPrimaryKey:@"identifier"];
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"ID",
                                           @"name" : @"Name",
                                           @"accCountDemo" : @"AccCountDemo",
                                           @"accCountLive" : @"AccCountLive",
                                           @"code" : @"Code",
                                           @"type" : @"Type",
                                           @"ibsCount" : @"IbsCount",
                                           @"groupType" : @"GroupType",
                                           @"main" : @"isMainOffice"
                                           }];
    
    [mapping addToManyRelationshipMapping:[BFMSysAccount defaultMapping]
                              forProperty:@"sysAccounts"
                                  keyPath:@"sysAccounts"];
    
    [mapping addToManyRelationshipMapping:[BFMAccount defaultMapping]
                              forProperty:@"accounts"
                                  keyPath:@"accounts"];
    
    return mapping;
}

@end
