//
//  BFMPrizeCategoriesViewModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategoriesViewModel.h"
#import "BFMPrize.h"

@implementation BFMPrizeCategoriesViewModel

- (void)loadCategoriesWithCallback:(void (^)(NSError *))completion {
	[BFMPrize prizeCategoriesWithCompletion:^(NSArray *categories, NSError *error) {
		completion(error);
	}];
}

@end
