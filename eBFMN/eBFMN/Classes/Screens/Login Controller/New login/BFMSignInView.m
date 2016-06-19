//
//  BFMSignInView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSignInView.h"

#import "BFMUserCredentials.h"

@interface BFMSignInView ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *credentialsFields;

@end

@implementation BFMSignInView

#pragma mark - Override

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UITextField *textfield in self.credentialsFields) {
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textfield.placeholder
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

#pragma mark - Public

- (BFMUserCredentials *)enteredCredentials {
    BFMUserCredentials *credentials = [[BFMUserCredentials alloc] initWithUsername:self.usernameTextField.text
                                                                          password:self.passwordTextField.text];
    return credentials;
}

#pragma mark - IBAction

- (IBAction)signInButtonTap:(id)sender {
    BFMUserCredentials *credentials = [self enteredCredentials];
    if (self.signInCompletion) {
        self.signInCompletion(credentials);
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self signInButtonTap:nil];
    }
    
    return NO;
}

@end
