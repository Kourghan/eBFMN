//
//  BFMAccountCell.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 30.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODSObjectConsuming.h"

@class BFMSysAccount;

@interface BFMAccountCell : UITableViewCell <ODSObjectConsuming>

@property (nonatomic, strong) BFMSysAccount *object;

@end