//
//  BFMPrizeCategory.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategory.h"
#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMPrizeCategory

+ (void)prizeCategoriesWithCompletion:(void (^)(NSArray *categories, NSError *error))completition {
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
				 NSArray *categories = [FEMDeserializer collectionFromRepresentation:[responseObject valueForKey:@"Data"]
																			 mapping:[BFMPrizeCategory defaultMapping]
																			 context:context];
				 [context MR_saveToPersistentStoreAndWait];
				 completition(categories, nil);
			 }
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 completition(nil, error);
		 }
	 ];
}

@end

@implementation BFMPrizeCategory (Mapping)

+ (FEMMapping *)defaultMapping {
	FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMPrizeCategory"];
	
	[mapping setPrimaryKey:@"identifier"];
	[mapping addAttributesFromDictionary:@{
										   @"identifier" : @"Id",
										   @"name" : @"Name",
										   @"link" : @"Link"
										   }
	 ];
	
	return mapping;
}

@end
