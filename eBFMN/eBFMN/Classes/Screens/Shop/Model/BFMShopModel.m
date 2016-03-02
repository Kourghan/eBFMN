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
#import "BFMPrizeCategory.h"

#import <MagicalRecord/MagicalRecord.h>

@interface BFMShopModel ()

@property (nonatomic, strong) BFMPrizeCategory *category;

@end

@implementation BFMShopModel

- (instancetype)initWithCategory:(BFMPrizeCategory *)category {
    if (self = [super init]) {
		self.category = category;
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"categoryId != -1"];
        
        NSFetchRequest *request = [BFMPrize MR_requestAllSortedBy:@"identifier"
                                                        ascending:YES
                                                    withPredicate:predicate
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
	[BFMPrize prizesInCategory:[self.category.identifier stringValue] withCompletion:^(NSArray *prizes, NSError *error) {
		completition(error);
	}];
}

@end
