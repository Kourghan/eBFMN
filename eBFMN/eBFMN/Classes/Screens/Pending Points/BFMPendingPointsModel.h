//
//  BFMPendingPointsModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMPendingPointsModel : NSObject

@property (nonatomic, strong) NSString *title;

- (void)loadDataWithCallback:(void (^)(NSError *error))callback;

@end
