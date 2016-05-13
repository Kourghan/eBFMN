//
//  BFMPrize2LinesViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrize2LinesViewController.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"
#import "BFMPrizeSingleLineView.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <ALAlertBanner/ALAlertBanner.h>
#import "BFMDefaultNavagtionBarAppearance.h"
#import "BFMPrizeSingleLineView.h"
#import "NINavigationAppearance.h"
#import "BFMPrizeLinesAdapter.h"
#import "BFMPrize+CoreDataProperties.h"
#import "BFMPrize.h"
#import "BFMColoredPrize.h"
#import "UIColor+Extensions.h"
#import "UIImageView+BFMSetImageRefresh.h"

@interface BFMPrize2LinesViewController ()

@property (nonatomic, weak) IBOutlet BFMPrizeLinesView *linesView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *prizeImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, strong) NSArray *prizes;

@end

@implementation BFMPrize2LinesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    self.linesView.selection = ^(BFMPrizeLinesView *lineView,
                                 NSInteger topIdx,
                                 NSInteger botIdx) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf updateOnSelection];
    };
    self.linesView.topAdapter.isOutline = NO;
    self.linesView.bottomAdapter.isOutline = YES;
    self.linesView.bottomAdapter.shouldPresentSummary = YES;
    self.linesView.topAdapter.pageControl = self.pageControl;
    
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor bfm_defaultNavigationBlue];
    self.pageControl.hidden = YES;
    self.pageControl.userInteractionEnabled = NO;
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

#pragma mark - Private

- (void)loadData {
    [self showContentViews:NO animated:NO];
    [BFMPrize getChildPrizesFrom:self.selectedPrize
                  withCompletion:^(NSArray *prizes, NSError *error) {
                      if (!error) {
                          [self showContentViews:YES animated:YES];
                          self.prizes = prizes;
                          [self updateOnResponse];
                      }
                  }];
}

- (void)updateOnResponse {
    BFMPrizeLinesView *lineView = self.linesView;
    lineView.topAdapter.objects = self.prizes;
    
    if (self.prizes.count) {
        BFMColoredPrize *coloredPrize = self.prizes.firstObject;
        NSArray *prizes = coloredPrize.prizes;
        lineView.bottomAdapter.objects = prizes;
        
        if (self.prizes.count > 4) {
            self.pageControl.numberOfPages = ceil(self.prizes.count / 4.f);
            self.pageControl.hidden = NO;
        } else {
            self.pageControl.hidden = YES;
        }
    } else {
        lineView.bottomAdapter.objects = nil;
    }
    
    lineView.topAdapter.selectedIndex = 0;
    lineView.bottomAdapter.selectedIndex = 0;
    [self updateOnSelection];
}

- (void)updateOnSelection {
    BFMPrizeLinesView *linesView = self.linesView;
    BFMColoredPrize *coloredPrize = self.prizes[linesView.topAdapter.selectedIndex];
    self.nameLabel.text = coloredPrize.name;
    BFMPrize *prize = coloredPrize.prizes[linesView.bottomAdapter.selectedIndex];
    NSString *URLString = [prize.iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    linesView.bottomAdapter.objects = coloredPrize.prizes;
    
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
    __weak typeof(self) weakSelf = self;
    [self.prizeImageView bfm_setImageWithURL:[NSURL URLWithString:URLString]
                                refreshAfter:2.0
                                  completion:^{
                                      [weakSelf.indicator stopAnimating];
                                      weakSelf.indicator.hidden = YES;
                                  }];
}

- (void)showContentViews:(BOOL)show animated:(BOOL)animated {
    CGFloat alpha = show ? 1.f : 0.f;
    for (UIView *subview in self.view.subviews) {
        if (!animated) {
            subview.alpha = alpha;
        } else {
            [UIView animateWithDuration:.3
                                  delay:.0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 subview.alpha = alpha;
                             }
                             completion:nil];
        }
    }
}

#pragma mark - IBAction

- (IBAction)saveButtonTap:(id)sender {
    BFMPrizeLinesView *linesView = self.linesView;
    BFMColoredPrize *coloredPrize = self.prizes[linesView.topAdapter.selectedIndex];
    BFMPrize *prize = coloredPrize.prizes[linesView.bottomAdapter.selectedIndex];
    [BFMPrize savePrize:prize withCompletition:^(NSError *error) {
        if (!error) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.view.window
                                                                style:ALAlertBannerStyleFailure
                                                             position:ALAlertBannerPositionTop
                                                                title:NSLocalizedString(@"error.error", nil)
                                                             subtitle:error.localizedDescription];
            [banner show];
        }
    }];
}

@end
