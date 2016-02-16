//
//  BFMShopModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ODSDataSource.h"

@interface BFMShopModel : NSObject

@property (nonatomic, strong) ODSDataSource *dataSource;

@property (nonatomic, strong) NSString *title;

- (void)loadPrizesWithCallback:(void (^)(NSError *error))completition;
- (void)loadPointsWithCallback:(void (^)(NSNumber *points, NSError *error))completition;

@end
