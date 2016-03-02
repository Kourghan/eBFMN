//
//  BFMColoredPrize.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.03.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMColoredPrize.h"
#import "BFMPrize.h"

#import <UIKit/UIColor.h>

@implementation BFMColoredPrize

- (UIColor *)bfm_color {
    return [[self class] colorFromHexString:self.hex];
}

- (BOOL)bfm_isFill {
    return YES;
}

- (NSString *)bfm_points {
    return @"";
}

- (NSString *)bfm_title {
    return self.name;
}

- (NSString *)bfm_summary {
    return self.name;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.f
                           green:((rgbValue & 0xFF00) >> 8)/255.f
                            blue:(rgbValue & 0xFF)/255.f
                           alpha:1.f];
}

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
