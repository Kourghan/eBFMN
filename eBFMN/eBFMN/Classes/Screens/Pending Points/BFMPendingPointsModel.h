//
//  BFMPendingPointsModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ODSDataSource;

@interface BFMPendingPointsModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) ODSDataSource *dataSource;

- (void)loadDataWithCallback:(void (^)(NSError *error))callback;

@end
