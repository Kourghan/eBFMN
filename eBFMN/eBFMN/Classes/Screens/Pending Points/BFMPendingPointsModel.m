//
//  BFMPendingPointsModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPendingPointsModel.h"
#import "BFMPointsRecord.h"

#import "ODSFetchedResultsDataSource.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMPendingPointsModel

- (instancetype)init {
    if (self = [super init]) {
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        NSFetchRequest *request = [BFMPointsRecord MR_requestAllSortedBy:@"identifier"
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
    return NSLocalizedString(@"points.title", nil);
}

- (void)loadDataWithCallback:(void (^)(NSError *))callback {
    [BFMPointsRecord currentPendingBonusData:^(NSArray *points, NSError *error) {
        if (!error) {
            [BFMPointsRecord pendingBonusDataHistory:^(NSArray *points, NSError *error) {
                if (!error) {
                    callback(nil);
                } else {
                    callback(error);
                }
            }];
        } else {
            callback(error);
        }
    }];
}

@end
