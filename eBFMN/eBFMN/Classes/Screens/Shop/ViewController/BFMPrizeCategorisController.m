//
//  BFMPrizeCategorisController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategorisController.h"
#import "BFMPrizeCategoriesViewModel.h"

@interface BFMPrizeCategorisController ()

@property (nonatomic, strong) BFMPrizeCategoriesViewModel *model;

@end

@implementation BFMPrizeCategorisController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.model = [BFMPrizeCategoriesViewModel new];
	[self.model loadCategoriesWithCallback:^(NSError *error) {
		
	}];
}



@end
