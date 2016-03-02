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



+ (void)prizesInCategory:(NSString *)idCategory withCompletion:(void (^)(NSArray *prizes, NSError * error))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeByCategoryForClient"
	  parameters:@{@"prizeCategoryId" : idCategory,
				   @"guid" : sessionKey
				   }
		 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
			 if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
				 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
				 completition(nil, [NSError new]);
			 } else {
				 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
				 NSArray *prizes = [FEMDeserializer  collectionFromRepresentation:[responseObject valueForKey:@"Data"]
																		  mapping:[BFMPrize defaultMapping]
																		  context:context];
				 [context MR_saveToPersistentStoreAndWait];
				 completition(prizes, nil);
			 }
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 completition(nil, error);
		 }
	 ];
}

+ (void)deleteAllPrizes {
	NSManagedObjectContext *ctx = [NSManagedObjectContext MR_defaultContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"BFMPrize" inManagedObjectContext:ctx]];
	[request setIncludesPropertyValues:NO]; //only fetch the managedObjectID
	
	NSError *error = nil;
	NSArray *objects = [ctx executeFetchRequest:request error:&error];
	
	//error handling goes here
	for (NSManagedObject *record in objects) {
		[ctx deleteObject:record];
	}
	NSError *saveError = nil;
	[ctx save:&saveError];
}

+ (void)getChildPrizesFrom:(BFMPrize *)prize withCompletion:(void (^)(NSArray *, NSError *))completition {
	if ([prize.prizeType integerValue] == BFMPrizeTypeText) {
		[BFMPrize getTextPrizesForPrize:prize withCompletion:completition];
	} else {
		[BFMPrize getColoredPrizesForPrize:prize withCompletion:completition];
	}
}

+ (void)getColoredPrizesForPrize:(BFMPrize *)prize withCompletion:(void (^)(NSArray *, NSError *))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeWithDescriptions"
	  parameters:@{@"prizeId" : [prize.identifier stringValue],
				   @"guid" : sessionKey
				   }
		 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
			 if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
				 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
				 completition(nil, [NSError new]);
			 } else {
				 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
				 NSArray *prizes = [FEMDeserializer  collectionFromRepresentation:[responseObject valueForKey:@"Data"]
																		  mapping:[BFMPrize defaultMapping]
																		  context:context];
				 [context MR_saveToPersistentStoreAndWait];
				 completition(prizes, nil);
			 }
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 completition(nil, error);
		 }
	 ];
}

+ (void)getTextPrizesForPrize:(BFMPrize *)prize withCompletion:(void (^)(NSArray *, NSError *))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeWithColorDetails"
	  parameters:@{@"prizeId" : [prize.identifier stringValue],
				   @"guid" : sessionKey
				   }
		 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
			 if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
				 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
				 completition(nil, [NSError new]);
			 } else {
				 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
				 NSArray *prizes = [FEMDeserializer  collectionFromRepresentation:[responseObject valueForKey:@"Data"]
																		  mapping:[BFMPrize defaultMapping]
																		  context:context];
				 [context MR_saveToPersistentStoreAndWait];
				 completition(prizes, nil);
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
										   @"iconURL" : @"DocumentLink",
										   @"categoryId" : @"CategoryId",
										   @"prizeType" : @"PrizeType",
										   @"oldPoints" : @"OldIBPoints",
										   @"summary" : @"Description"
										   }
	 ];
	
	return mapping;
}

@end
