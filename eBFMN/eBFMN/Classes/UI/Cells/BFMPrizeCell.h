//
//  BFMPrizeCell.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODSObjectConsuming.h"

@class BFMPrize;

@interface BFMPrizeCell : UICollectionViewCell <ODSObjectConsuming>

@property (nonatomic, strong) BFMPrize *object;

@end
