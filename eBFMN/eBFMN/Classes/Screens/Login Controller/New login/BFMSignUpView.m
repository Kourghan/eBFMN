//
//  BFMSignUpView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSignUpView.h"

#import "BFMSignUpCredentials.h"

@interface BFMSignUpView()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *emailTF;
@property (nonatomic, weak) IBOutlet UITextField *passwordTF;

@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *credentialsFields;

@end

@implementation BFMSignUpView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UITextField *textfield in self.credentialsFields) {
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textfield.placeholder
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
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
