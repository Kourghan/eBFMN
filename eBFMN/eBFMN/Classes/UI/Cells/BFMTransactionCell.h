//
//  BFMTransactionCell.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODSObjectConsuming.h"

@class BFMPointsRecord;

@interface BFMTransactionCell : UITableViewCell <ODSObjectConsuming>

@property (nonatomic, strong) BFMPointsRecord *object;

@end
