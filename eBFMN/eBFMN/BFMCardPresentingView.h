//
//  BFMCardPresentingView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/10/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BFMCardPresentingViewSide) {
    BFMCardPresentingViewSideFront = 0,
    BFMCardPresentingViewSideBack
};

@interface BFMCardPresentingView : UIView

@property (nonatomic, readonly) BFMCardPresentingViewSide currentSide;
@property (nonatomic, readonly, getter = isAnimating) BOOL animating;

- (void)loadNib:(NSString *)nibName side:(BFMCardPresentingViewSide)side;
- (void)showSide:(BFMCardPresentingViewSide)side animated:(BOOL)animated;
- (void)switchSide;

@end
