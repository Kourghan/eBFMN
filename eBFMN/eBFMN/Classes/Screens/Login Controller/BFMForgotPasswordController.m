//
//  BFMForgotPasswordController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 25.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMForgotPasswordController.h"
#import "BFMUserCredentials.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <MessageUI/MessageUI.h>

@interface BFMForgotPasswordController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;

@end

@implementation BFMForgotPasswordController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.usernameTextfield.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.usernameTextfield.layer.borderWidth = 1.f;
    self.usernameTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.usernameTextfield.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.usernameTextfield.text = self.credentials.username;
}

#pragma mark - handlers

- (IBAction)getPassword:(id)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    __weak typeof(self) weakSelf = self;
    self.credentials.username = self.usernameTextfield.text;
    [self.credentials remindPasswordWithCompletitionBlock:^(NSInteger code, NSError *error) {
        [SVProgressHUD dismiss];
        if (code == BFMNetworkStateSuccess) {
            [weakSelf.presentingViewController dismissViewControllerAnimated:YES
                                                              completion:nil];
        } else if (code == BFMNetworkStateFailed) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"status.failed.passwordReminder", nil)];
        }
    }];
}

- (IBAction)contactUs:(id)sender {
    [self openMailComposer];
}

- (IBAction)termsAndConditions:(id)sender {

}

- (IBAction)back:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
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

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    [self getPassword:nil];
    
    return YES;
}

@end
