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

@interface BFMPendingPointsModel ()

@property (nonatomic, strong) NSDate *dateFrom;
@property (nonatomic, strong) NSDate *dateTo;

@property (nonatomic) BOOL allLoaded;

@end

@implementation BFMPendingPointsModel

- (instancetype)init {
    if (self = [super init]) {
        
        _allLoaded = NO;
        
        
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
    if (self.allLoaded) {
        callback(nil);
    } else {
        __weak typeof(self) weakSelf = self;
        if (self.dateFrom && self.dateTo) {
            self.dateTo = [_dateFrom copy];
        } else {
            self.dateTo = [NSDate date];
        }
        self.dateFrom = [_dateTo dateByAddingTimeInterval:-(60 * 60 * 24 * 60)];
        [BFMPointsRecord currentPendingBonusData:^(NSArray *points, NSError *error) {
            if (!error) {
                [BFMPointsRecord pendingBonusDataHistoryFromDate:weakSelf.dateFrom
                                                          toDate:weakSelf.dateTo
                                                    completition:^(NSArray *points, NSError *error) {
                                                        if (!error) {
                                                            if ([points count] == 0) {
                                                                weakSelf.allLoaded = TRUE;
                                                            }
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
}

@end
