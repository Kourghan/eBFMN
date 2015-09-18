//
//  BFMNotificationsModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 18.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ODSDataSource;

@interface BFMNotificationsModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ODSDataSource *dataSource;

@end
