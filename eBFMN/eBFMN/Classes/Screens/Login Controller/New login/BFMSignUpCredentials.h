//
//  BFMSignUpCredentials.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/14/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BFMSignUpRole) {
    BFMSignUpRoleOffice = 2,
    BFMSignUpRoleSP = 3,
    BFMSignUpRoleIB = 4
};

extern NSString *bfm_nameWithRole(BFMSignUpRole role);

@interface BFMSignUpCredentials : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *number;

- (BOOL)isFilled;
- (NSString *)errorStringForFirstScreen:(NSString *)existing;
- (NSString *)appendReason:(NSString *)reason existingString:(NSString *)existing;

@end
