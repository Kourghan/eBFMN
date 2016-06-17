//
//  BFMFirstViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMFirstViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import "UIViewController+Error.h"
#import "BFMUserCredentials.h"
#import "BFMSignInProvider.h"
#import "UIView+BFMLoad.h"
#import "BFMSignUpView.h"
#import "BFMSignInView.h"

typedef NS_ENUM(NSInteger, BFMFirstTypePage) {
    BFMFirstTypePageSignIn = 0,
    BFMFirstTypePageSignUp
};

@interface BFMFirstViewController ()

@property (nonatomic, strong) BFMSignInProvider *provider;
@property (nonatomic, assign) BFMFirstTypePage currentPage;

@property (nonatomic, weak) IBOutlet UIView *signInContainerView;
@property (nonatomic, weak) IBOutlet UIView *signUpContainerView;
@property (nonatomic, weak) IBOutlet UIView *containersContainer;
@property (nonatomic, weak) IBOutlet UIView *navButtonsContainer;
@property (nonatomic, weak) IBOutlet UIView *bgImageContainer;
@property (nonatomic, weak) IBOutlet UIView *recognizerView;
@property (nonatomic, weak) IBOutlet BFMSignInView *signInView;
@property (nonatomic, weak) IBOutlet BFMSignUpView *signUpView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *signInLeftConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *signInButtonCenterConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *signUpButtonCenterConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bgImageConstraint;

@end

@implementation BFMFirstViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = BFMFirstTypePageSignIn;
    [self setupProvider];
    [self setupContentViews];
    [self setupRecognizer];
    [self switchToPage:BFMFirstTypePageSignIn];
}

#pragma mark - Setup

- (void)setupProvider {
    self.provider = [BFMSignInProvider new];
}

- (void)setupRecognizer {
    SEL leftSel = @selector(handleLeftSwipe:);
    UISwipeGestureRecognizer *GR = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                             action:leftSel];
    GR.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.containersContainer addGestureRecognizer:GR];
    
    SEL rightSel = @selector(handleRightSwipe:);
    UISwipeGestureRecognizer *GR2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                              action:rightSel];
    [self.containersContainer addGestureRecognizer:GR2];
}

- (void)setupContentViews {
    __weak typeof(self) weakSelf = self;
    
    BFMSignInView *signInView = [BFMSignInView bfm_load];
    signInView.frame = self.signInContainerView.bounds;
    [self.signInContainerView addSubview:signInView];
    self.signInView = signInView;
    signInView.signInCompletion = ^(BFMUserCredentials *credentials) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [weakSelf.provider signIn:credentials
                       completion:^(NSString *errorString) {
                           [SVProgressHUD dismiss];
                           if (errorString.length) {
                               [weakSelf showError:errorString];
                           }
                       }];
    };
    signInView.passwordCompletion = ^(BFMUserCredentials *credentials) {
        [weakSelf showForgotPass:credentials];
    };
    
    BFMSignUpView *signUpView = [BFMSignUpView bfm_load];
    signUpView.frame = self.signUpContainerView.bounds;
    [self.signUpContainerView addSubview:signUpView];
    self.signUpView = signUpView;
    signUpView.signUpCompletion = ^(BFMSignUpCredentials *credentials) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [weakSelf.provider signUp:credentials
                       completion:^(NSString *errorString) {
                           [SVProgressHUD dismiss];
                           if (errorString.length) {
                               [weakSelf showError:errorString];
                           }
                       }];
    };
}

#pragma mark - Pages switching

- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)GR {
    [self switchToPage:BFMFirstTypePageSignUp];
}

- (void)handleRightSwipe:(UISwipeGestureRecognizer *)GR {
    [self switchToPage:BFMFirstTypePageSignIn];
}

- (void)switchToPage:(BFMFirstTypePage)page {
    CGFloat scrW = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat signInLeftConstant = (page == BFMFirstTypePageSignIn) ? 0 : -scrW;
    
    self.signInLeftConstraint.constant = signInLeftConstant;
    [self.containersContainer setNeedsUpdateConstraints];
    [UIView animateWithDuration:.25
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.containersContainer layoutIfNeeded];
                     } completion:nil];
    
    
    self.signInButtonCenterConstraint.constant = (page == BFMFirstTypePageSignIn) ? 0.f : (-scrW / 2.f);
    self.signUpButtonCenterConstraint.constant = (page == BFMFirstTypePageSignIn) ? (scrW / 2.f) : 0.f;
    [self.navButtonsContainer setNeedsUpdateConstraints];
    [UIView animateWithDuration:.25
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.navButtonsContainer layoutIfNeeded];
                     } completion:nil];
    
    self.bgImageConstraint.constant = (page == BFMFirstTypePageSignIn) ? 0.f : -(scrW / 5.f);
    [self.bgImageContainer setNeedsUpdateConstraints];
    [UIView animateWithDuration:.25
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.bgImageContainer layoutIfNeeded];
                     } completion:nil];
}

#pragma mark - Private

- (void)showError:(NSString *)error {
    [self bfm_showErrorInOW:NSLocalizedString(@"error.error", nil)
                   subtitle:error];
}

- (void)showForgotPass:(BFMUserCredentials *)username {
    
}

@end
