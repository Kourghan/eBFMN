//
//  BFMSignInProvider.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSignInProvider.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>
#import "BFMSignUpCredentials.h"
#import "BFMUserCredentials.h"
#import "BFMUser+Extension.h"
#import "BFMSessionManager.h"
#import "BFMSignUpCountry.h"
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

- (void)getCountries:(BFMCountriesCompletion)completion {
    BFMSessionManager *manager = [BFMSessionManager sharedManager];
    [manager GET:@"Registration/GetCountries"
      parameters:@{}
         success:^(NSURLSessionDataTask *task, NSDictionary *response) {
             NSArray *objects = [BFMSignUpCountry objectsFromResponse:response];
             if (completion) {
                 completion(objects, nil);
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             if (completion) {
                 completion(nil, error.localizedDescription);
             }
         }];
}

@end
