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
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)signUpButtonTap:(id)sender {
    BFMSignUpCredentials *credentials = [self fillCredetials];
    if (self.signUpCompletion && credentials) {
        self.signUpCompletion(credentials);
    }
}

- (BFMSignUpCredentials *)fillCredetials {
    BFMSignUpCredentials *credentials = [BFMSignUpCredentials new];
    
    return credentials;
}


@end
