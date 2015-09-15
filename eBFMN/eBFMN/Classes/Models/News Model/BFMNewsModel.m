//
//  BFMNewsModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsModel.h"

#import "BFMNewsCell.h"
#import "BFMNewsRecord.h"

#import <MagicalRecord/MagicalRecord.h>
#import "ODSFetchedResultsDataSource.h"

@implementation BFMNewsModel

- (instancetype)init {
    if (self = [super init]) {
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        [self stubInContext:context];
        
        NSFetchRequest *request = [BFMNewsRecord MR_requestAllSortedBy:@"identifier"
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
    return NSLocalizedString(@"news.title", nil);
}

- (void)stubInContext:(NSManagedObjectContext *)context {
    BFMNewsRecord *rec1 = [BFMNewsRecord MR_createEntityInContext:context];
    rec1.title = @"This is short title";
    
    BFMNewsRecord *rec2 = [BFMNewsRecord MR_createEntityInContext:context];
    rec2.title = @"This is";
    
    BFMNewsRecord *rec3 = [BFMNewsRecord MR_createEntityInContext:context];
    rec3.title = @"This is short title This is short title This is short title. This is short title This is short title";
    
    BFMNewsRecord *rec4 = [BFMNewsRecord MR_createEntityInContext:context];
    rec4.title = @"This is short";
    
    BFMNewsRecord *rec5 = [BFMNewsRecord MR_createEntityInContext:context];
    rec5.title = @"This is This is short title  title";
}

@end
