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
#import <MessageUI/MessageUI.h>

#pragma mark - DEBUG

#import "BFMLeaderboardModel.h"

@interface BFMLoginController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

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
        controller.credentials = [[BFMUserCredentials alloc] initWithUsername:self.usernameTextField.text
                                                                     password:self.passwordTextField.text];
    }
}

#pragma mark - Private

- (BOOL)dataVerified {
    return [self.passwordTextField.text length] > 0 && [self.usernameTextField.text length] > 0;
}

#pragma mark - Handlers

- (IBAction)loginButtonTapped:(id)sender {
    if ([self dataVerified]) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        
        BFMUserCredentials *credentials = [[BFMUserCredentials alloc] initWithUsername:self.usernameTextField.text
                                                                              password:self.passwordTextField.text];
        [credentials loginWithCompletitionBlock:^(BOOL success, NSError *error) {
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
    [self openMailComposer];
}

#pragma mark - Mail Composer

- (void)openMailComposer {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [MFMailComposeViewController new];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"techsupport@bmfn.com"]];
        [self showViewController:composeViewController sender:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    
    return YES;
}

@end
