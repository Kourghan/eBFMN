//
//  BFMColoredPrize.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.03.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMColoredPrize.h"
#import "BFMPrize.h"

@implementation BFMColoredPrize

@end

@implementation BFMColoredPrize (Mapping)

+ (FEMMapping *)defaultMapping {
	FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[BFMColoredPrize class]];
	
	[mapping setPrimaryKey:@"name"];
	[mapping addAttributesFromDictionary:@{
										   @"name" : @"ColorName",
										   @"hex" : @"ColorValue",
										   @"link" : @"DocumentLink"
										   }
	 ];
	
	return mapping;
}

@end
