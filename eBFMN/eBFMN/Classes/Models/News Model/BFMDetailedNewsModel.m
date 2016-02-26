//
//  BFMDetailedNewsModel.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 05.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMDetailedNewsModel.h"

#import "BFMNewsRecord.h"

@interface BFMDetailedNewsModel ()

@property (nonatomic, strong) BFMNewsRecord *record;

@end

@implementation BFMDetailedNewsModel

- (instancetype)initWithRecord:(BFMNewsRecord *)record {
    if (self = [super init]) {
        _record = record;
    }
    
    return self;
}

- (void)fetchDetailedWithCallback:(void (^)(BFMNewsRecord *record, NSError *))callback {
    [self.record getDetailsWithCompletition:^(BFMNewsRecord *record, NSError *error) {
        callback(record, error);
    }];
}

@end
