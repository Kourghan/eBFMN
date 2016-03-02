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

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <ALAlertBanner/ALAlertBanner.h>
#import "BFMDefaultNavagtionBarAppearance.h"
#import "BFMPrizeSingleLineView.h"
#import "NINavigationAppearance.h"
#import "BFMPrizeLinesAdapter.h"
#import "BFMPrize+CoreDataProperties.h"
#import "BFMPrize.h"
#import "BFMColoredPrize.h"

@interface BFMPrize2LinesViewController ()

@property (nonatomic, weak) IBOutlet BFMPrizeLinesView *linesView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *prizeImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) NSArray *prizes;

@end

@implementation BFMPrize2LinesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.prizeImageView setImageWithURL:[NSURL URLWithString:URLString]];
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
