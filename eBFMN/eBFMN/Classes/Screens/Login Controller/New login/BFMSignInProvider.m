//
//  BFMSignInProvider.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSignInProvider.h"

#import "BFMSignUpCredentials.h"
#import "BFMUserCredentials.h"
#import "BFMUser+Extension.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@implementation BFMSignInProvider

- (void)signIn:(BFMUserCredentials *)credentials
    completion:(BFMSignUpCompletion)completion {
    
    if (![credentials isFilled]) {
        if (completion) {
            completion(NSLocalizedString(@"login.emptyfields", @""));
        }
        return;
    }
    
    [credentials loginWithCompletitionBlock:^(BOOL success, NSError *error) {
        if (success) {
            [BFMUser getInfoWithCompletitionBlock:^(BOOL success) {
                if (success) {
                    if (completion) {
                        completion(nil);
                    }
                    [(AppDelegate *)[UIApplication sharedApplication].delegate showHome];
                } else {
                    if (completion) {
                        completion(NSLocalizedString(@"login.wrongcredentials", @""));
                    }
                }
            }];
        } else {
            if (error) {
                if (completion) {
                    completion(NSLocalizedString(@"error.connection", nil));
                }
            } else {
                if (completion) {
                    completion(NSLocalizedString(@"login.wrongcredentials", @""));
                }
            }
        }
    }];
}

- (void)signUp:(BFMSignUpCredentials *)credentials
    completion:(BFMSignUpCompletion)completion {
    
    if (![credentials isFilled]) {
        if (completion) {
            completion(NSLocalizedString(@"login.emptyfields", @""));
        }
        return;
    }
    
    if (completion) {
        completion(nil);
    }
    
}

@end
