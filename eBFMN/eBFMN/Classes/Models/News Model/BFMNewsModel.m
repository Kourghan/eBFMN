//
//  BFMNewsModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsModel.h"

#import "BFMNewsCell.h"
#import "BFMNewsRecord+Mapping.h"

#import <MagicalRecord/MagicalRecord.h>
#import "ODSFetchedResultsDataSource.h"
#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"
#import <FastEasyMapping/FastEasyMapping.h>

static NSString *kLastNewsUpdateUserDefaultsKey = @"kLastNewsUpdateUserDefaultsKey";

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
    //[self fetchNews]; // Uncoment+Test when backend implement neews feed
    }
    return self;
}

- (void)refresh {
    //[self fetchNews];
}

- (void) fetchNews {
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kLastNewsUpdateUserDefaultsKey]) {
        [self getNewsFromDateInUnix:[[NSUserDefaults standardUserDefaults] stringForKey:kLastNewsUpdateUserDefaultsKey] success:^(NSArray *records) {
            for (BFMNewsRecord *record in records) {
                BFMNewsRecord *savedRecord = [BFMNewsRecord MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                savedRecord = record;
            }
        } failure:^(NSError *error) {
            
        }];
    } else {
        NSDate *date = [[NSDate alloc] init];
        NSString *dateString = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
        [[NSUserDefaults standardUserDefaults] setValue:dateString forKey:kLastNewsUpdateUserDefaultsKey];
        [self getNewsFromDateInUnix:[[NSUserDefaults standardUserDefaults] stringForKey:kLastNewsUpdateUserDefaultsKey] success:^(NSArray *records) {
            for (BFMNewsRecord *record in records) {
                BFMNewsRecord *savedRecord = [BFMNewsRecord MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                savedRecord = record;
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)getNewsFromDateInUnix:(NSString *) dateInUnixFormat success:(void (^)(NSArray *records))successBlock failure:(void (^)(NSError *error))failureBlock {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    NSDictionary *params = @{@"guid" : sessionKey, @"from" :  dateInUnixFormat};
    [manager GET:@"Reports/GetNews"
      parameters:params
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            // NSLog(@"Response: %@", responseObject);
             if (![responseObject isEqual: @[]]) {
                 NSArray *records =  [FEMDeserializer collectionFromRepresentation:[responseObject objectForKey:@"Data"] mapping:[BFMNewsRecord defaultMapping]];
                // NSLog(@"Records: %@", records);
                 successBlock(records);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             failureBlock(error);
         }];
}

- (NSString *)title {
    return NSLocalizedString(@"news.title", nil);
}

- (void)stubInContext:(NSManagedObjectContext *)context {
    BFMNewsRecord *rec1 = [BFMNewsRecord MR_createEntityInContext:context];
    rec1.title = @"This is short title";
    rec1.text = @"A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text. Finished.";
    rec1.date = [NSDate date];
    
    BFMNewsRecord *rec2 = [BFMNewsRecord MR_createEntityInContext:context];
    rec2.title = @"This is";
    rec2.text = @"A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text A long text. Finished.";
    rec2.date = [NSDate date];
    
    BFMNewsRecord *rec3 = [BFMNewsRecord MR_createEntityInContext:context];
    rec3.title = @"This is short title This is short title This is short title. This is short title This is short title";
    rec3.text = @"This is a short text This is a short text This";
    rec3.date = [NSDate date];
    
    BFMNewsRecord *rec4 = [BFMNewsRecord MR_createEntityInContext:context];
    rec4.title = @"This is short";
    rec4.text = @"This is a short text This is a short text This";
    rec4.date = [NSDate date];
    
    BFMNewsRecord *rec5 = [BFMNewsRecord MR_createEntityInContext:context];
    rec5.title = @"This is This is short title  title";
    rec5.text = @"This is a short text This is a short text This";
    rec5.date = [NSDate date];
    
}

@end
