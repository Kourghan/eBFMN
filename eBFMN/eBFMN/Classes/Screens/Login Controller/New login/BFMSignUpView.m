//
//  BFMSignUpView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSignUpView.h"

#import "UITextField+BFMPlaceholderColor.h"
#import "BFMSignUpCredentials.h"

@interface BFMSignUpView()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *credentialsFields;

@end

@implementation BFMSignUpView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.credentialsFields = @[
                               self.emailTF,
                               self.firstNameTF,
                               self.lastNameTF,
                               self.phoneTF,
                               self.numberTF
                               ];
    
    for (UITextField *textfield in self.credentialsFields) {
        [textfield bfm_whitify];
    }
    
    [self.roleTF bfm_whitify];
    [self.countryTF bfm_whitify];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![self.credentialsFields containsObject:textField]) {
        return NO;
    }
    
    NSUInteger idx = [self.credentialsFields indexOfObject:textField];
    if (idx < self.credentialsFields.count - 1) {
        UITextView *nextField = self.credentialsFields[idx + 1];
        [nextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return NO;
}

- (IBAction)signUpButtonTap:(id)sender {
    BFMSignUpCredentials *credentials = [self fillCredetials];
    if (self.signUpCompletion && credentials) {
        self.signUpCompletion(credentials);
    }
}

- (IBAction)countryButtonTap:(id)sender {
    if (self.countryCallback) {
        self.countryCallback();
    }
}

- (BFMSignUpCredentials *)fillCredetials {
    BFMSignUpCredentials *credentials = [BFMSignUpCredentials new];
    
    return credentials;
}

@end
