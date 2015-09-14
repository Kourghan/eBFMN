//
//  BFMNewsModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsModel.h"

#import "ACFetchedResultsDataSource.h"
#import "BFMNewsCell.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMNewsModel

- (instancetype)init {
    if (self = [super init]) {
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"BFMNewsRecord"];
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]
                                                  initWithFetchRequest:request
                                                  managedObjectContext:context
                                                  sectionNameKeyPath:nil
                                                  cacheName:nil
                                                  ];
        self.dataSource = [[ACFetchedResultsDataSource alloc] initWith:controller
                                                             cellClass:[BFMNewsCell class]];
    }
    
    return self;
}

- (NSString *)title {
    return NSLocalizedString(@"news.title", nil);
}

@end
