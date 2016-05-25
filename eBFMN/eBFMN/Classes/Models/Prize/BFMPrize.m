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
#import "BFMColoredPrize.h"

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
             completition(nil);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(error);
         }
     ];
}

+ (void)currentPrizeWithComplatition:(void (^)(BFMPrize * prize, NSError * error))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	if (sessionKey.length == 0) {
		return;
	}
	
    [manager GET:@"Bonus/GetSelectedPrize"
      parameters:@{
                   @"guid" : sessionKey
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             id data = [responseObject valueForKey:@"Data"];
             if ((data == nil) || ([data isKindOfClass:[NSNull class]])) {
                 completition(nil, [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                                       code:1002
                                                   userInfo:nil]);
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
             id data = [responseObject valueForKey:@"Data"];
             if ((data == nil) || ([data isKindOfClass:[NSNull class]])) {
                 completition(nil, [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                                       code:1002
                                                   userInfo:nil]);
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
    if (!prize) {
        return;
    }
    
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeWithColorDetails"
	  parameters:@{@"prizeId" : [prize.identifier stringValue],
				   @"guid" : sessionKey
				   }
		 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             id data = [responseObject valueForKey:@"Data"];
             if ((data == nil) || ([data isKindOfClass:[NSNull class]])) {
                 completition(nil, [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                                       code:1002
                                                   userInfo:nil]);
             } else {
				 NSArray *rawData = [responseObject valueForKey:@"Data"];
				 NSMutableArray *prizes = [NSMutableArray array];
				 
				 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
				 
				 for (NSDictionary *singleData in rawData) {
					 BFMColoredPrize *coloredPrize = [FEMDeserializer objectFromRepresentation:singleData mapping:[BFMColoredPrize defaultMapping]];
					 NSArray *subPrizes = [FEMDeserializer collectionFromRepresentation:[singleData valueForKey:@"Prizes"] mapping:[BFMPrize defaultMapping] context:context];
					 
					 for (BFMPrize *newPrize in subPrizes) {
						 newPrize.categoryId = @(-1);
					 }
					 
					 coloredPrize.prizes = subPrizes;
					 
					 [prizes addObject:coloredPrize];
				 }
				 
				 [context MR_saveToPersistentStoreAndWait];
				 completition([prizes copy], nil);
			 }
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 completition(nil, error);
		 }
	 ];
}

+ (void)getTextPrizesForPrize:(BFMPrize *)prize withCompletion:(void (^)(NSArray *, NSError *))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeWithDescriptions"
	  parameters:@{@"prizeId" : [prize.identifier stringValue],
				   @"guid" : sessionKey
				   }
		 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             id data = [responseObject valueForKey:@"Data"];
             if ((data == nil) || ([data isKindOfClass:[NSNull class]])) {
                 completition(nil, [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                                       code:1002
                                                   userInfo:nil]);
             } else {
				 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
				 NSArray *prizes = [FEMDeserializer  collectionFromRepresentation:[responseObject valueForKey:@"Data"]
																		  mapping:[BFMPrize defaultMapping]
																		  context:context];
				 for (BFMPrize *newPrize in prizes) {
					 newPrize.categoryId = @(-1);
				 }
				 [context MR_saveToPersistentStoreAndWait];
				 completition(prizes, nil);
			 }
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 completition(nil, error);
		 }
	 ];
}

+ (void)getPrize:(NSNumber *)identifier
      completion:(void (^)(BFMPrize *prize, NSError *error))completion {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    [manager GET:@"Bonus/GetPrizeInfoByID"
      parameters:@{@"prizeId" : identifier.stringValue,
                   @"guid" : sessionKey
                   }
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             id data = [responseObject valueForKey:@"Data"];
             if ((data == nil) || ([data isKindOfClass:[NSNull class]])) {
                 completion(nil, [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                                     code:1002
                                                 userInfo:nil]);
             } else {
                 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
//                 NSArray *prizes = [FEMDeserializer  collectionFromRepresentation:[responseObject valueForKey:@"Data"]
//                                                                          mapping:[BFMPrize defaultMapping]
//                                                                          context:context];
//                 for (BFMPrize *newPrize in prizes) {
//                     newPrize.categoryId = @(-1);
//                 }
				 BFMPrize *prize = [FEMDeserializer objectFromRepresentation:data
																	 mapping:[BFMPrize defaultMapping]
																	 context:context];
				 
				 
				 
				 
                 [context MR_saveToPersistentStoreAndWait];
                 completion(prize, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completion(nil, error);
         }
     ];
}

+ (void)prizeTypeById:(NSNumber *)identifier completion:(void (^)(BFMPrizeType type, NSError *))completion {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeType"
	  parameters:@{@"prizeID" : identifier.stringValue,
				   @"guid" : sessionKey
				   }
		 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             id data = [responseObject valueForKey:@"Data"];
             if ((data == nil) || ([data isKindOfClass:[NSNull class]])) {
                 completion(BFMPrizeTypePlain, [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
                                                                   code:1002
                                                               userInfo:nil]);
             } else {
				 BFMPrizeType type = [[responseObject objectForKey:@"Data"] intValue];
				 completion(type, nil);
			 }
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 completion(BFMPrizeTypeText, error);
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
