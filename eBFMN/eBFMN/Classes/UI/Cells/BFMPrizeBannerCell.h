//
//  BFMPrizeBannerCell.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODSObjectConsuming.h"

@class BFMBanner;

@interface BFMPrizeBannerCell : UICollectionViewCell<ODSObjectConsuming>

@property (nonatomic, strong) BFMBanner *object;

@end
