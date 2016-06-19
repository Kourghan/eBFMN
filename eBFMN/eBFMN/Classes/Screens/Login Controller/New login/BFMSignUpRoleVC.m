//
//  BFMSignUpRoleVC.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSignUpRoleVC.h"

@implementation BFMSignUpRoleVC

- (IBAction)IBButtonTap:(id)sender {
    if (self.completion) {
        self.completion(BFMSignUpRoleIB);
    }
}

- (IBAction)SPButtonTap:(id)sender {
    if (self.completion) {
        self.completion(BFMSignUpRoleSP);
    }
}

@end
