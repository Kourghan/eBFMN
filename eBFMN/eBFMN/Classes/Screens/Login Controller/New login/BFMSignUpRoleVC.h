//
//  BFMSignUpRoleVC.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMSignUpCredentials.h"

typedef void (^BFMSignUpRoleVCCompletion)(BFMSignUpRole role);

@interface BFMSignUpRoleVC : UIViewController

@property (nonatomic, copy) BFMSignUpRoleVCCompletion completion;

@end
