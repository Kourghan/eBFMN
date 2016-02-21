//
//  BFMPrize.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPrize.h"
#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"
#import "BFMPrizeCategory.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMPrize

+ (void)savePrize:(BFMPrize *)prize withCompletition:(void (^)(NSError * error))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Bonus/SetSelectedPrize"
      parameters:@{
                   @"guid" : sessionKey,
                   @"prizeID" : prize.identifier
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
                 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
                 completition([NSError new]);
             } else {
                 completition(nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(error);
         }
     ];
}

+ (void)currentPrizeWithComplatition:(void (^)(BFMPrize * prize, NSError * error))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Bonus/GetSelectedPrize"
      parameters:@{
                   @"guid" : sessionKey
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
                 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
                 completition(nil, [NSError new]);
             } else {
                 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
                 BFMPrize *prize = [FEMDeserializer  objectFromRepresentation:[responseObject valueForKey:@"Data"]
                                                                      mapping:[BFMPrize defaultMapping]
                                                                      context:context];
                 [context MR_saveToPersistentStoreAndWait];
                 completition(prize, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

+ (void)prizeBannerWithCompletion:(void (^)(NSArray * banners, NSError * error))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeCategories"
		parameters:@{
								 @"guid" : sessionKey
								 }
			 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
				 if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
						 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
					 completition(nil, [NSError new]);
				 } else {
					 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
					 BFMPrize *prize = [FEMDeserializer  objectFromRepresentation:[responseObject valueForKey:@"Data"]
																																mapping:[BFMPrize defaultMapping]
																																context:context];
					 [context MR_saveToPersistentStoreAndWait];
					 completition(prize, nil);
				 }
			 } failure:^(NSURLSessionDataTask *task, NSError *error) {
				 completition(nil, error);
			 }
	 ];
}

+ (void)prizesInCategory:(NSString *)idCategory withCompletion:(void (^)(NSArray *prizes, NSError * error))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeCategories"
		parameters:@{
								 @"guid" : sessionKey
								 }
			 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
				 if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
						 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
					 completition(nil, [NSError new]);
				 } else {
					 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
					 BFMPrize *prize = [FEMDeserializer  objectFromRepresentation:[responseObject valueForKey:@"Data"]
																																mapping:[BFMPrize defaultMapping]
																																context:context];
					 [context MR_saveToPersistentStoreAndWait];
					 completition(prize, nil);
				 }
			 } failure:^(NSURLSessionDataTask *task, NSError *error) {
				 completition(nil, error);
			 }
	 ];
}

@end

@implementation BFMPrize (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMPrize"];
	
    [mapping setPrimaryKey:@"identifier"];
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"Id",
                                           @"name" : @"Name",
                                           @"points" : @"IBPoints",
                                           @"iconURL" : @"DocumentLink"
                                           }
     ];
    
    return mapping;
}

@end
