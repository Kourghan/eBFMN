//
//  BFMPrizeCategoryCell.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODSObjectConsuming.h"

@class BFMPrizeCategory;

@interface BFMPrizeCategoryCell : UICollectionViewCell <ODSObjectConsuming>

@property (nonatomic, strong) BFMPrizeCategory *object;

@end