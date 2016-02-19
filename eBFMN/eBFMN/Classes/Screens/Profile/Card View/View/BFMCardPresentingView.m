//
//  BFMCardPresentingView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/10/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMCardPresentingView.h"

static NSTimeInterval const kBFMCardAnimationDuration = .95;
static CGFloat const kBFMAdoptionScreeWidth = 320.f;
static CGSize const kBFMCardSideAt320PtWidthScreen = (CGSize){306.f, 193.f};

@interface BFMCardPresentingView ()

@property (nonatomic, readwrite) BFMCardPresentingViewSide currentSide;
@property (nonatomic, readwrite, getter = isAnimating) BOOL animating;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *heightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *widthConstraint;

@property (nonatomic, strong, readwrite) UIView *frontView;
@property (nonatomic, strong, readwrite) UIView *backView;

@end

@implementation BFMCardPresentingView

#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    self.frontView.frame = bounds;
    self.backView.frame = bounds;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self adoptForSmallerScreenSizes];
}

#pragma mark - Public

- (void)loadNib:(NSString *)nibName side:(BFMCardPresentingViewSide)side {
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *topLevelViews = [bundle loadNibNamed:nibName
                                            owner:nil
                                          options:nil];
    UIView *view = topLevelViews.firstObject;
    [self setupView:view side:side];
}

- (void)showSide:(BFMCardPresentingViewSide)side animated:(BOOL)animated {
    if (!animated) {
        for (UIView *subview in self.subviews) {
            [subview removeFromSuperview];
        }
        UIView *view = [self viewForSide:side];
        view.frame = self.bounds;
        [self addSubview:view];
        self.currentSide = side;
        return;
    }
    
    if (side == self.currentSide) {
        return;
    }
    
    if (self.isAnimating) {
        return;
    }
    
    self.animating = YES;
    UIViewAnimationOptions left = UIViewAnimationOptionTransitionFlipFromLeft;
    UIViewAnimationOptions rig = UIViewAnimationOptionTransitionFlipFromRight;
    BFMCardPresentingViewSide back = BFMCardPresentingViewSideBack;
    UIViewAnimationOptions opt1 = (self.currentSide == back) ? rig : left;
    UIViewAnimationOptions opt2 = UIViewAnimationOptionBeginFromCurrentState;
    UIViewAnimationOptions opt3 = UIViewAnimationOptionCurveEaseInOut;
    UIView *fromView = [self viewForSide:self.currentSide];
    UIView *toView = [self viewForReverseSide:self.currentSide];
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:kBFMCardAnimationDuration
                       options:(opt1 | opt2 | opt3)
                    completion:^(BOOL finished) {
                        [fromView removeFromSuperview];
                        [self addSubview:toView];
                        self.currentSide = side;
                        self.animating = NO;
                    }];
}

- (void)switchSide {
    [self showSide:[self reverseSide:self.currentSide]
          animated:YES];
}

- (void)setupView:(UIView *)view side:(BFMCardPresentingViewSide)side {
    if (side == BFMCardPresentingViewSideFront) {
        self.frontView = view;
    } else {
        self.backView = view;
    }
}

#pragma mark - Private (accessor methods)

- (UIView *)viewForSide:(BFMCardPresentingViewSide)side {
    if (side == BFMCardPresentingViewSideFront) {
        return self.frontView;
    }
    
    return self.backView;
}

- (UIView *)viewForReverseSide:(BFMCardPresentingViewSide)side {
    if (side == BFMCardPresentingViewSideFront) {
        return self.backView;
    }
    
    return self.frontView;
}

- (BFMCardPresentingViewSide)reverseSide:(BFMCardPresentingViewSide)side {
    if (side == BFMCardPresentingViewSideFront) {
        return BFMCardPresentingViewSideBack;
    }
    
    return BFMCardPresentingViewSideFront;
}

#pragma mark - Private (misc)

- (void)adoptForSmallerScreenSizes {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (screenWidth <= kBFMAdoptionScreeWidth) {
        CGSize size = kBFMCardSideAt320PtWidthScreen;
        self.widthConstraint.constant = size.width;
        self.heightConstraint.constant = size.height;
    }
}

@end
