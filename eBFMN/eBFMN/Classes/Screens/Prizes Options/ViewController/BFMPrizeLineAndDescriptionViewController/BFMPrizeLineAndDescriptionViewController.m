//
//  BFMPrizeLineAndDescriptionViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeLineAndDescriptionViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <ALAlertBanner/ALAlertBanner.h>
#import "BFMDefaultNavagtionBarAppearance.h"
#import "BFMPrizeSingleLineView.h"
#import "NINavigationAppearance.h"
#import "BFMPrizeLinesAdapter.h"
#import "BFMPrize+CoreDataProperties.h"
#import "BFMPrize.h"

@interface BFMPrizeLineAndDescriptionViewController ()

@property (nonatomic, weak) IBOutlet BFMPrizeSingleLineView *linesView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *prizeImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) NSArray *prizes;

@end

@implementation BFMPrizeLineAndDescriptionViewController

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
    BFMPrizeSingleLineView *lineView = self.linesView;
    lineView.topAdapter.objects = self.prizes;
    lineView.topAdapter.selectedIndex = 0;
    [self updateOnSelection];
}

- (void)updateOnSelection {
    BFMPrize *prize = self.prizes[self.linesView.topAdapter.selectedIndex];
    self.nameLabel.text = prize.name;
    self.descriptionLabel.text = prize.summary;
    [self.prizeImageView setImageWithURL:[NSURL URLWithString:[prize.iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
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
