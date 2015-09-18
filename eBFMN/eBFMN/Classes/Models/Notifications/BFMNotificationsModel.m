//
//  BFMNotificationsModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 18.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNotificationsModel.h"

#import "BFMNotification.h"

#import <MagicalRecord/MagicalRecord.h>
#import "ODSFetchedResultsDataSource.h"

@implementation BFMNotificationsModel

- (instancetype)init {
    if (self = [super init]) {
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        [self stubInContext:context];
        
        NSFetchRequest *request = [BFMNotification MR_requestAllSortedBy:@"identifier"
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
    return NSLocalizedString(@"notifications.title", nil);
}

- (void)stubInContext:(NSManagedObjectContext *)context {
    BFMNotification *rec1 = [BFMNotification MR_createEntityInContext:context];
    rec1.title = @"This is short title";
    rec1.content = @"Shot conedfjhg";
    
    BFMNotification *rec2 = [BFMNotification MR_createEntityInContext:context];
    rec2.title = @"This is";
    rec2.content = @"This is short title This is short title This is short title. This is short title This is short title";
    
    BFMNotification *rec3 = [BFMNotification MR_createEntityInContext:context];
    rec3.title = @"This is short title This is short title This is short title. This is short title This is short title";
    rec3.content = @"This is short title This is short title This is short title. This is short title This is short title";
    
    BFMNotification *rec4 = [BFMNotification MR_createEntityInContext:context];
    rec4.title = @"This is short 33";
    rec4.content = @"This is short title This is short title This is short title. This is short title This is short title";
    
    BFMNotification *rec5 = [BFMNotification MR_createEntityInContext:context];
    rec5.title = @"This is This is short title  title";
    rec5.content = @"This is short title This is This is short title This is short title This is short title. This is short title This is short title This is short title This is short title This is short title. This is short title This is short title This is short title This is short title This is short title. This is short title This is short title  short title This is short title. This is short title This is short title";
}

@end
