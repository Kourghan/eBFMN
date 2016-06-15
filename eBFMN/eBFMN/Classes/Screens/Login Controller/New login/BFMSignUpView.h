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

@interface BFMSignUpView : UIView

@property (nonatomic, copy) BFMSignUpViewCompletion signUpCompletion;

@end
