//
//  BFMSignInView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMUserCredentials;

typedef void (^BFMSignInViewCompletion)(BFMUserCredentials *credentials);

@interface BFMSignInView : UIView

@property (nonatomic, copy) BFMSignInViewCompletion signInCompletion;
@property (nonatomic, copy) BFMSignInViewCompletion passwordCompletion;

- (BFMUserCredentials *)enteredCredentials;

@end
