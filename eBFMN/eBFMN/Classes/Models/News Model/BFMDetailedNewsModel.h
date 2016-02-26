//
//  BFMDetailedNewsModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 05.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFMNewsRecord;

@interface BFMDetailedNewsModel : NSObject

- (instancetype)initWithRecord:(BFMNewsRecord *)record;

@property (nonatomic, strong) NSString *title;

- (void)fetchDetailedWithCallback:(void (^)(BFMNewsRecord *record, NSError *error))callback;

@end
