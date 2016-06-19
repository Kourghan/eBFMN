//
//  BFMFirstViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMFirstViewController.h"

#import <WYPopoverController/WYPopoverController.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "BFMCountryViewController.h"
#import "UIViewController+Error.h"
#import "BFMKeyboardObserver.h"
#import "BFMUserCredentials.h"
#import "BFMSignInProvider.h"
#import "BFMSignUpCountry.h"
#import "BFMSignUpRoleVC.h"
#import "UIView+BFMLoad.h"
#import "BFMSignUpView.h"
#import "BFMSignInView.h"

typedef NS_ENUM(NSInteger, BFMFirstTypePage) {
    BFMFirstTypePageSignIn = 0,
    BFMFirstTypePageSignUp
};

@interface BFMFirstViewController ()<BFMKeyboardObserverDelegate, WYPopoverControllerDelegate>

@property (nonatomic, strong) WYPopoverController *popover;
@property (nonatomic, strong) BFMSignUpRoleVC *roleVC;
@property (nonatomic, strong) BFMSignInProvider *provider;
@property (nonatomic, assign) BFMFirstTypePage currentPage;
@property (nonatomic, strong) BFMSignUpCountry *country;

@property (nonatomic, strong) IBOutlet BFMKeyboardObserver *kbObserver;
@property (nonatomic, weak) IBOutlet UIView *signInContainerView;
@property (nonatomic, weak) IBOutlet UIView *signUpContainerView;
@property (nonatomic, weak) IBOutlet UIView *containersContainer;
@property (nonatomic, weak) IBOutlet UIView *navButtonsContainer;
@property (nonatomic, weak) IBOutlet UIButton *signInNavButton;
@property (nonatomic, weak) IBOutlet UIButton *signUpNavButton;
@property (nonatomic, weak) IBOutlet UIView *bgImageContainer;
@property (nonatomic, weak) IBOutlet BFMSignInView *signInView;
@property (nonatomic, weak) IBOutlet BFMSignUpView *signUpView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *signInLeftConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *signInButtonCenterConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *signUpButtonCenterConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bgImageConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *containerViewTopConstr;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *navViewTopConstr;

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
    
    [self.provider getCountries:nil];
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
    
    self.signInView.signInCompletion = ^(BFMUserCredentials *credentials) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [weakSelf.provider signIn:credentials
                       completion:^(NSString *errorString) {
                           [SVProgressHUD dismiss];
                           if (errorString.length) {
                               [weakSelf showError:errorString];
                           }
                       }];
    };
    self.signInView.passwordCompletion = ^(BFMUserCredentials *credentials) {
        [weakSelf showForgotPass:credentials];
    };
    
    self.signUpView.signUpCompletion = ^(BFMSignUpCredentials *credentials) {
//        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
//        [weakSelf.provider signUp:credentials
//                       completion:^(NSString *errorString) {
//                           [SVProgressHUD dismiss];
//                           if (errorString.length) {
//                               [weakSelf showError:errorString];
//                           }
//                       }];
        
        [weakSelf.provider validateSignUp:credentials
                               completion:^(NSString *errorString) {
                                   if (errorString.length) {
                                       [weakSelf bfm_showErrorInKW:@"" subtitle:errorString duration:6.];
                                   }
                               }];
    };
    self.signUpView.countryCallback = ^{
        [weakSelf showSelectCountry];
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
    if (!self.kbObserver.isKbVisible) {
        [self performAnimationToPage:page];
        return;
    }
    
    [self.view endEditing:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performAnimationToPage:page];
    });
}

- (void)performAnimationToPage:(BFMFirstTypePage)page {
    self.currentPage = page;
    
    CGFloat scrW = CGRectGetWidth([UIScreen mainScreen].bounds);
    BOOL isSignIn = (page == BFMFirstTypePageSignIn);
    
    CGFloat signInLeftConstant = isSignIn ? 0 : -scrW;
    NSTimeInterval ti = .25;
    
    self.signInLeftConstraint.constant = signInLeftConstant;
    [self.containersContainer setNeedsUpdateConstraints];
    [UIView animateWithDuration:ti
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.containersContainer layoutIfNeeded];
                     } completion:nil];
    
    CGFloat midOffset = 35.f;
    self.signInButtonCenterConstraint.constant = isSignIn ? 0.f : (-scrW / 2.f - midOffset);
    self.signUpButtonCenterConstraint.constant = isSignIn ? (scrW / 2.f + midOffset) : 0.f;
    [self.navButtonsContainer setNeedsUpdateConstraints];
    [UIView animateWithDuration:ti
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.navButtonsContainer layoutIfNeeded];
                     } completion:nil];
    
    self.bgImageConstraint.constant = isSignIn ? 0.f : -(scrW * 0.5);
    [self.bgImageContainer setNeedsUpdateConstraints];
    [UIView animateWithDuration:ti
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.bgImageContainer layoutIfNeeded];
                     } completion:nil];
    
    [UIView animateWithDuration:ti
                     animations:^{
                         CGFloat maxA = 1.f;
                         CGFloat minA = .1f;
                         self.signInNavButton.alpha = isSignIn ? maxA : minA;
                         self.signUpNavButton.alpha = isSignIn ? minA : maxA;
                     }];
}

#pragma mark - Private

- (void)showError:(NSString *)error {
    [self bfm_showErrorInOW:NSLocalizedString(@"error.error", nil)
                   subtitle:error];
}

- (void)showForgotPass:(BFMUserCredentials *)username {
    
}

- (void)showSelectCountry {
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryNav"];
    BFMCountryViewController *vc = (id)navController.topViewController;
    
    __weak typeof(self) weakSelf = self;
    vc.selection = ^(BFMSignUpCountry *country) {
        weakSelf.country = country;
        weakSelf.signUpView.countryTF.text = country.name;
    };
    vc.selectedID = self.country.identifier;
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - BFMKeyboardObserverDelegate

- (void)keyboardObserver:(BFMKeyboardObserver *)observer
   animateKeyboardHeight:(CGFloat)height
                duration:(NSTimeInterval)duration
                   curve:(UIViewAnimationCurve)curve {
    
    if (self.currentPage == BFMFirstTypePageSignIn) {
        return;
    }
    
    BOOL kbHidden = (fabs(height) < 0.01);
    self.navViewTopConstr.constant = kbHidden ? 19.f : 19.f + 88.f - height;
    self.containerViewTopConstr.constant = kbHidden ? 0.f : -height + 88;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:duration
                          delay:.0
                        options:(curve << 16)
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:nil];
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller {
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller {
    self.popover.delegate = nil;
    self.popover = nil;
    self.roleVC = nil;
}

#pragma mark - IBAction

- (IBAction)signInNavButtonTap:(id)sender {
    [self switchToPage:BFMFirstTypePageSignIn];
}

- (IBAction)signUpNavButtonTap:(id)sender {
    [self switchToPage:BFMFirstTypePageSignUp];
}

- (IBAction)signUpSelectRoleButtonTap:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    
    BFMSignUpRoleVC *roleVC = [BFMSignUpRoleVC new];
    roleVC.completion = ^(BFMSignUpRole role) {
        weakSelf.signUpView.roleTF.text = bfm_nameWithRole(role);
        [weakSelf.popover dismissPopoverAnimated:YES];
    };
    roleVC.preferredContentSize = CGSizeMake(60.f, 80.f);
    
    CGRect senderRect = [sender convertRect:sender.bounds toView:self.view];
    WYPopoverController *popover = [[WYPopoverController alloc] initWithContentViewController:roleVC];
    
    WYPopoverTheme *theme = [WYPopoverTheme theme];
    theme.fillBottomColor = [UIColor colorWithRed:31.f / 255.f
                                            green:85.f / 255.f
                                             blue:124.f / 255.f
                                            alpha:1.f];
    theme.tintColor = [UIColor colorWithRed:31.f / 255.f
                                      green:85.f / 255.f
                                       blue:124.f / 255.f
                                      alpha:1.f];
    popover.theme = theme;
    self.popover = popover;
    
    [popover presentPopoverFromRect:senderRect
                             inView:self.view
           permittedArrowDirections:WYPopoverArrowDirectionDown
                           animated:YES];
}

@end
