//
//  BFMNewsCell.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODSObjectConsuming.h"

@class BFMNewsRecord;

@interface BFMNewsCell : UITableViewCell <ODSObjectConsuming>

@property (nonatomic, strong) BFMNewsRecord *object;

@end
