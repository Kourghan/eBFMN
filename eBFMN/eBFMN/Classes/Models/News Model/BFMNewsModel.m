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
#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"
#import <FastEasyMapping/FastEasyMapping.h>

static NSString *kLastNewsUpdateUserDefaultsKey = @"kLastNewsUpdateUserDefaultsKey";

@interface BFMNewsModel ()

@property (nonatomic) int page;

@end

@implementation BFMNewsModel

- (instancetype)init {
    if (self = [super init]) {
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        NSFetchRequest *request = [BFMNewsRecord MR_requestAllSortedBy:@"date"
                                                             ascending:NO
                                                         withPredicate:nil
                                                             inContext:context];
        
        NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]
                                                  initWithFetchRequest:request
                                                  managedObjectContext:context
                                                  sectionNameKeyPath:nil
                                                  cacheName:nil
                                                  ];
        
    self.dataSource = [[ODSFetchedResultsDataSource alloc] initWithFetchedResultsController:controller];
    //[self fetchNews]; // Uncoment+Test when backend implement neews feed
		
		self.page = 0;
		
    }
    return self;
}

- (void)loadNewsReset:(BOOL)reset callback:(void (^)(NSError *))callback {
	if (reset == YES) {
		self.page = 0;
		[BFMNewsRecord deleteAll];
	}
	[BFMNewsRecord getNews:self.page
				  pageSize:10
                  withCompletition:^(NSArray *prizes, NSError *error) {
					  if (!error) {
						  self.page += 1;
					  }
                      callback(error);
                  }
     ];
}

- (NSString *)title {
    return NSLocalizedString(@"tabbar.news", nil);
}

@end
