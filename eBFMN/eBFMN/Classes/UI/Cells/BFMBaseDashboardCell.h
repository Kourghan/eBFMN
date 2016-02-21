//
//  BFMBaseDashboardCell.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMUser;

@interface BFMBaseDashboardCell : UITableViewCell

@property (nonatomic, strong) BFMUser *user;

- (void)bind:(BFMUser *) user;

@end
