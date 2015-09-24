//
//  ViewController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMLoginController.h"
#import "BFMUserCredentials.h"
#import "UIStoryboard+BFMStoryboards.h"
#import "BFMTabBarController.h"
#import "BFMUser+Extension.h"
#import "BFMForgotPasswordController.h"

#import <SVProgressHUD/SVProgressHUD.h>

#pragma mark - DEBUG

#import "BFMLeaderboardModel.h"

@interface BFMLoginController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *contactUsButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *termsButton;

@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *credentialsFields;

@end

@implementation BFMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UITextField *textfield in self.credentialsFields) {
        textfield.layer.borderColor = [[UIColor whiteColor] CGColor];
        textfield.layer.borderWidth = 1.f;
        
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textfield.placeholder
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"forgotPassword"]) {
        BFMForgotPasswordController *controller = (BFMForgotPasswordController *)segue.destinationViewController;
        if ([self.usernameTextField.text length] > 0) {
            controller.credentials = self.usernameTextField.text;
        }
    }
}

#pragma mark - Private

- (BOOL)dataVerified {
    return [self.passwordTextField.text length] > 0 && [self.usernameTextField.text length] > 0;
}

#pragma mark - Handlers

- (IBAction)loginButtonTapped:(id)sender {
    if ([self dataVerified]) {
        [SVProgressHUD show];
        
        BFMUserCredentials *credentials = [[BFMUserCredentials alloc] initWithUsername:self.usernameTextField.text
                                                                              password:self.passwordTextField.text];
        [credentials loginWithCompletitionCompletitionBlock:^(BOOL success, NSError *error) {
            if (success) {
                [BFMUser getInfoWithCompletitionBlock:^(BOOL success) {
                    if (success) {
                        BFMTabBarController *tabBarVC = [[UIStoryboard tabBarStoryboard] instantiateInitialViewController];
                        [self showViewController:tabBarVC sender:self];
                    } else {
                        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login.wrongcredentials", @"")];
                    }
                    [SVProgressHUD dismiss];
                }];
            } else {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:error.description];
                } else {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login.wrongcredentials", @"")];
                }
            }
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login.emptyfields", @"")];
    }
}

- (IBAction)termsButtonTapped:(id)sender {

}

- (IBAction)contactUsButtonTapped:(id)sender {
    
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    
    return YES;
}

@end
