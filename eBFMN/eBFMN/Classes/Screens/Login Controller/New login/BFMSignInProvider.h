//
//  BFMSignInProvider.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFMSignUpCredentials, BFMUserCredentials;

typedef void (^BFMSignUpCompletion)(NSString *errorString);
typedef void (^BFMCountriesCompletion)(NSArray *countries, NSString *errorString);

@interface BFMSignInProvider : NSObject

- (void)signIn:(BFMUserCredentials *)credentials
    completion:(BFMSignUpCompletion)completion;
- (void)signUp:(BFMSignUpCredentials *)credentials
    completion:(BFMSignUpCompletion)completion;
- (void)getCountries:(BFMCountriesCompletion)completion;

@end
