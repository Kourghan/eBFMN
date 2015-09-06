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

@implementation BFMUser (Extension)

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
             
//             [FEMManagedObjectDeserializer objectFromRepresentation:[response copy]
//                                                            mapping:[BFMUser defaultMapping]
//                                                            context:context];
             completition(YES);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(NO);
         }];
}

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMUser" rootPath:@"Data"];
    
    [mapping setPrimaryKey:@"identifier"];
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"ID",
                                           @"name" : @"Name",
                                           @"accCount" : @"AccCount",
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
