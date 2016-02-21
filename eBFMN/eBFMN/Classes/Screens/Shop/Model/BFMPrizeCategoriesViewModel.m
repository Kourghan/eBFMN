//
//  BFMPrizeCategoriesViewModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategoriesViewModel.h"
#import "BFMPrizeCategory.h"
#import "ODSFetchedResultsDataSource.h"

#import <MagicalRecord.h>

@implementation BFMPrizeCategoriesViewModel

- (instancetype)init {
	if (self = [super init]) {
		NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
		
		NSFetchRequest *request = [BFMPrizeCategory MR_requestAllSortedBy:@"identifier"
														ascending:YES
													withPredicate:nil
														inContext:context];
		
		NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]
												  initWithFetchRequest:request
												  managedObjectContext:context
												  sectionNameKeyPath:nil
												  cacheName:nil
												  ];
		self.dataSource = [[ODSFetchedResultsDataSource alloc] initWithFetchedResultsController:controller];
	}
	return self;
}

- (void)loadCategoriesWithCallback:(void (^)(NSError *))completion {
	[BFMPrizeCategory prizeCategoriesWithCompletion:^(NSArray *categories, NSError *error) {
		completion(error);
	}];
}

@end
