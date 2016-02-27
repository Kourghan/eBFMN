//
//  BFMBanner.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMBanner.h"

#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMBanner

+ (void)bannersWithCompletion:(void (^)(NSArray * banners, NSError * error))completition {
	BFMSessionManager *manager = [BFMSessionManager sharedManager];
	
	NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	[manager GET:@"Bonus/GetPrizeBanners"
	  parameters:@{
				   @"guid" : sessionKey
				   }
		 success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
			 if ([[responseObject valueForKey:@"Key"] isEqualToString:@"ErrorOccured"] ||
				 [[responseObject valueForKey:@"Key"] isEqualToString:@"YouNeedToLogin"]) {
				 completition(nil, [NSError new]);
			 } else {
				 NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
				 NSArray *banners = [FEMDeserializer  collectionFromRepresentation:[responseObject valueForKey:@"Data"]
																		   mapping:[BFMBanner defaultMapping]
																		   context:context];
				 [context MR_saveToPersistentStoreAndWait];
				 completition(banners, nil);
			 }
		 } failure:^(NSURLSessionDataTask *task, NSError *error) {
			 completition(nil, error);
		 }
	 ];
}

@end

@implementation BFMBanner (Mapping)

+ (FEMMapping *)defaultMapping {
	FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMBanner"];
	
	[mapping setPrimaryKey:@"identifier"];
	[mapping addAttributesFromDictionary:@{
										   @"identifier" : @"Id",
										   @"prizeId" : @"PrizeId",
										   @"link" : @"Link"
										   }
	 ];
	
	return mapping;
}

@end
