//
//  BFMPrizeCategory.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategory.h"

@implementation BFMPrizeCategory

// Insert code here to add functionality to your managed object subclass

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
