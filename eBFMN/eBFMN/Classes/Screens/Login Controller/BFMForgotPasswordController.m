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

@interface BFMForgotPasswordController ()

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
    [self.credentials remindPasswordWithCompletitionBlock:^(BOOL success, NSError *error) {
        if (success) {
            [SVProgressHUD dismiss];
            [self.presentingViewController dismissViewControllerAnimated:YES
                                                              completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"status.failed.passwordReminder", nil)];
        }
    }];
}

- (IBAction)contactUs:(id)sender {
    
}

- (IBAction)termsAndConditions:(id)sender {

}

- (IBAction)back:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

@end
