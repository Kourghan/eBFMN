//
//  BFMSignUpView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMSignUpCredentials;

typedef void (^BFMSignUpViewCompletion)(BFMSignUpCredentials *credentials);
typedef void (^BFMSignUpCountryCallback)();

@interface BFMSignUpView : UIView

@property (nonatomic, weak) IBOutlet UITextField *emailTF;
@property (nonatomic, weak) IBOutlet UITextField *firstNameTF;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTF;
@property (nonatomic, weak) IBOutlet UITextField *countryTF;
@property (nonatomic, weak) IBOutlet UITextField *phoneTF;
@property (nonatomic, weak) IBOutlet UITextField *roleTF;
@property (nonatomic, weak) IBOutlet UITextField *numberTF;

@property (nonatomic, copy) BFMSignUpViewCompletion signUpCompletion;
@property (nonatomic, copy) BFMSignUpCountryCallback countryCallback;

@end
