//
//  BFMNewsRecord.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 14.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsRecord.h"

#import "BFMSessionManager.h"
#import "JNKeychain+UNTExtension.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation BFMNewsRecord

+ (void)getNews:(NSInteger)page pageSize:(NSInteger)pageSize withCompletition:(void (^)(NSArray *, NSError *))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
	
	// (string guid, string language, int pageSize, int page)
	
    NSDictionary *params = @{
							 @"guid" : sessionKey,
							 @"page" : @(page),
							 @"pageSize" : @(pageSize),
							 @"language" : @"en" // temp lang
							 };
    [manager GET:@"Reports/GetCabinetNews"
      parameters:params
         success:^(NSURLSessionDataTask *task, NSArray *responseObject) {
             if (![responseObject isEqual: @[]]) {
                 NSManagedObjectContext *ctx = [NSManagedObjectContext MR_defaultContext];
                 NSArray *records = [FEMDeserializer collectionFromRepresentation:responseObject
                                                                          mapping:[BFMNewsRecord defaultMapping]
                                                                          context:ctx];
                 [ctx MR_saveToPersistentStoreAndWait];
                 completition(records, nil);
             } else {
                 completition(nil, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

- (void)getDetailsWithCompletition:(void (^)(BFMNewsRecord *, NSError *))completition {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    
    NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
    
    NSInteger date = [self.date timeIntervalSince1970];
    
    NSDictionary *params = @{
                             @"guid" : sessionKey,
                             @"date" : @(date),
                             @"id" : self.textIdentifier
                             };
	
	__weak typeof(self) weakSelf = self;
	
    [manager GET:@"Reports/GetNewsTextRecord"
      parameters:params
         success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
             if (responseObject) {
				 NSManagedObjectContext *ctx = weakSelf.managedObjectContext;
				 weakSelf.text = responseObject[@"Text"];
                 [ctx MR_saveToPersistentStoreAndWait];
                 completition(self, nil);
             } else {
                 completition(nil, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             completition(nil, error);
         }
     ];
}

+ (NSInteger)unixLatestNewsDate {
    NSArray *news = [BFMNewsRecord MR_findAllSortedBy:@"date" ascending:NO];
    if ([news count] > 0) {
        BFMNewsRecord *latesNews = [news firstObject];
        NSInteger timestamp = [latesNews.date timeIntervalSince1970];
        return timestamp;
    } else {
        return 1446336000;
    }
}

- (NSString *)formattedDate {
    return [[BFMNewsRecord recordDateFormatter] stringFromDate:self.date];
}

+ (NSDateFormatter *)recordDateFormatter {
    static NSDateFormatter *internalRecordDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        internalRecordDateFormatter = [NSDateFormatter new];
        internalRecordDateFormatter.dateFormat = @"EEEE, dd/MM/yyyy";
    });
    return internalRecordDateFormatter;
}

@end

@implementation BFMNewsRecord (Mapping)

+ (FEMMapping *)detailsMapping {
	FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMNewsRecord"];
	mapping.primaryKey = @"identifier";
	
	
	[mapping addAttributesFromDictionary:@{
										   @"identifier" : @"_id",
										   @"text" : @"Text"
										   }];
	
	return mapping;
}

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"BFMNewsRecord"];
    mapping.primaryKey = @"identifier";
    
    
    [mapping addAttributesFromDictionary:@{
                                           @"identifier" : @"_id",
                                           @"title" : @"Title",
                                           @"shortText" : @"ShortText",
										   @"textIdentifier" : @"NewsTextID"
                                           }];
    
    FEMAttribute *attribute = [[FEMAttribute alloc] initWithProperty:@"date"
                                                             keyPath:@"Date"
                                                                 map:^id(id value) {
                                                                     if ([value isKindOfClass:[NSString class]]) {
                                                                         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                         [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
                                                                         return [formatter dateFromString:value];
                                                                     }
                                                                     return nil;
                                                                 } reverseMap:^id(id value) {
                                                                     return [value stringValue];
                                                                 }];
    [mapping addAttribute:attribute];

    
    return mapping;
}

@end