//
//  BFMEarningsPage.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMBasePageController.h"

@protocol BFMEarningsPageDelegate;

@interface BFMEarningsPage : BFMBasePageController

@property (nonatomic, weak) id<BFMEarningsPageDelegate> delegate;

@end

@protocol BFMEarningsPageDelegate <NSObject>

- (void)showPrizes;

@end
