//
//  BFMPrizeLineAndDescriptionViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeLineAndDescriptionViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIViewController+Error.h"
#import "BFMDefaultNavagtionBarAppearance.h"
#import "BFMPrizeSingleLineView.h"
#import "NINavigationAppearance.h"
#import "BFMPrizeLinesAdapter.h"
#import "BFMPrize+CoreDataProperties.h"
#import "BFMPrize.h"
#import "UIImageView+BFMSetImageRefresh.h"
#import "UIViewController+Error.h"

@interface BFMPrizeLineAndDescriptionViewController ()

@property (nonatomic, weak) IBOutlet BFMPrizeSingleLineView *linesView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *prizeImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSArray *prizes;

@end

@implementation BFMPrizeLineAndDescriptionViewController

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
    self.linesView.topAdapter.isOutline = YES;
    
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
    
    if (self.selectedPrize.prizeType.integerValue == BFMPrizeTypePlain) {
        self.linesView.hidden = YES;
        [self showContentViews:YES animated:YES];
        self.prizes = @[self.selectedPrize];
        [self updateOnResponse];
        return;
    }
    
    [BFMPrize getChildPrizesFrom:self.selectedPrize
                  withCompletion:^(NSArray *prizes, NSError *error) {
                      if (!error) {
                          [self showContentViews:YES animated:YES];
                          self.prizes = prizes;
                          [self updateOnResponse];
                      }
                      
                      if (error) {
                          [self bfm_showError];
                      }
                  }];
}

- (void)updateOnResponse {
    BFMPrizeSingleLineView *lineView = self.linesView;
    lineView.topAdapter.objects = self.prizes;
    lineView.topAdapter.selectedIndex = 0;
    [self updateOnSelection];
}

- (void)updateOnSelection {
    BFMPrize *prize = self.prizes[self.linesView.topAdapter.selectedIndex];
    self.nameLabel.text = prize.name;
    self.descriptionLabel.text = prize.summary;
    
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
    __weak typeof(self) weakSelf = self;
    NSURL *URL = [NSURL URLWithString:[prize.iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.prizeImageView bfm_setImageWithURL:URL
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
    BFMPrize *prize = self.prizes[self.linesView.topAdapter.selectedIndex];
    [BFMPrize savePrize:prize withCompletition:^(NSError *error) {
        if (!error) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [self bfm_showErrorInOW:NSLocalizedString(@"error.error", nil)
                           subtitle:error.localizedDescription];
        }
    }];
}

@end
