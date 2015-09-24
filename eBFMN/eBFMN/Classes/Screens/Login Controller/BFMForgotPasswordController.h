//
//  BFMForgotPasswordController.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 25.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMUserCredentials;

@interface BFMForgotPasswordController : UIViewController

@property (nonatomic, strong) BFMUserCredentials *credentials;

@end
