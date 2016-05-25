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
#import "BFMPrize.h"
#import "BFMBanner.h"

#import "MagicalRecord.h"

@implementation BFMPrizeCategoriesViewModel

- (instancetype)init {
	if (self = [super init]) {
		[self setupDataSource];
		[self setupBannerDataSource];
	}
	return self;
}

- (void)setupDataSource {
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

- (void)setupBannerDataSource {
	NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
	
	NSFetchRequest *request = [BFMBanner MR_requestAllSortedBy:@"identifier"
													 ascending:YES
												 withPredicate:nil
													 inContext:context];
	
	NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]
											  initWithFetchRequest:request
											  managedObjectContext:context
											  sectionNameKeyPath:nil
											  cacheName:nil
											  ];
	self.bannerDataSource = [[ODSFetchedResultsDataSource alloc] initWithFetchedResultsController:controller];
}

- (void)loadCategoriesWithCallback:(void (^)(NSError *))completion {
	[BFMPrizeCategory prizeCategoriesWithCompletion:^(NSArray *categories, NSError *error) {
		completion(error);
	}];
}

- (void)loadBannersWithCallback:(void (^)(NSArray *banners, NSError *))completion {
	[BFMBanner bannersWithCompletion:^(NSArray *banners, NSError *error) {
		completion(banners, error);
	}];
}

@end
