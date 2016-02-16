//
//  BFMShopModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMShopModel.h"
#import "ODSFetchedResultsDataSource.h"

#import "BFMPrize.h"
#import "BFMUser+Extension.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation BFMShopModel

- (instancetype)init {
    if (self = [super init]) {
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        NSFetchRequest *request = [BFMPrize MR_requestAllSortedBy:@"identifier"
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

- (NSString *)title {
    return NSLocalizedString(@"prizes.title", nil);
}

- (void)loadPointsWithCallback:(void (^)(NSNumber *points, NSError *error))completition {
    [BFMUser getPointsCount:^(NSNumber *points, NSError *error) {
        completition(points, error);
    }];
}

- (void)loadPrizesWithCallback:(void (^)(NSError *))completition {
	[BFMPrize prizeCategoriesWithCompletion:^(NSArray *categories, NSError *error) {
		completition(error);
	}];
//    [BFMPrize prizesWithCompletition:^(NSArray * prizes, NSError * error) {
//        completition(error);
//    }];
}

@end
