//
//  BFMSignUpCredentials.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSignUpCredentials.h"

NSString *bfm_nameWithRole(BFMSignUpRole role) {
    switch (role) {
        case BFMSignUpRoleOffice: return @"Office";
        case BFMSignUpRoleIB: return @"IB";
        case BFMSignUpRoleSP: return @"SP";
        default: return @"";
    }
};

@implementation BFMSignUpCredentials

- (BOOL)isFilled {
    return YES;
}

@end
