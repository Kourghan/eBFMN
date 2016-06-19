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

- (NSString *)errorStringForFirstScreen:(NSString *)existing {
    NSString *result = existing.copy;
    
    if (!self.email.length) {
        result = [self appendReason:@"Missing email field" existingString:result];
    }
    
    if (!self.firstName.length) {
        result = [self appendReason:@"Missing first name field" existingString:result];
    } else {
        if (self.firstName.length > 255) {
            result = [self appendReason:@"First name should be longer than 255 characters"
                         existingString:result];
        }
        
        NSCharacterSet *nAlphaSet = [NSCharacterSet letterCharacterSet].invertedSet;
        if ([self.firstName rangeOfCharacterFromSet:nAlphaSet].location != NSNotFound) {
            result = [self appendReason:@"First name should contain only lettes"
                         existingString:result];
        }
    }
    
    if (!self.lastName.length) {
        result = [self appendReason:@"Missing last name field" existingString:result];
    } else {
        if (self.lastName.length > 255) {
            result = [self appendReason:@"Last name should be longer than 255 characters"
                         existingString:result];
        }
        
        NSCharacterSet *nAlphaSet = [NSCharacterSet letterCharacterSet].invertedSet;
        if ([self.lastName rangeOfCharacterFromSet:nAlphaSet].location != NSNotFound) {
            result = [self appendReason:@"Last name should contain only lettes"
                         existingString:result];
        }
    }
    
    if (!self.phone.length) {
        result = [self appendReason:@"Missing phone field" existingString:result];
    } else {
        NSString *regex = @"/^(\\+?\\d+)?\\s*(\\(\\d+\\))?[\\s-]*([\\d-]*)$/";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if (![predicate evaluateWithObject:self.phone]) {
            result = [self appendReason:@"Incorrect phone number format"
                         existingString:result];
        }
    }
    
    if (!self.country.length) {
        result = [self appendReason:@"Missing country field" existingString:result];
    }
    
    if (!self.type.length) {
        result = [self appendReason:@"Missing role field" existingString:result];
    }
    
    if (!self.number.length) {
        result = [self appendReason:@"Missing code field" existingString:result];
    } else {
        NSCharacterSet *nAlphaSet = [NSCharacterSet decimalDigitCharacterSet].invertedSet;
        if ([self.lastName rangeOfCharacterFromSet:nAlphaSet].location != NSNotFound) {
            result = [self appendReason:@"Code should contain only digits"
                         existingString:result];
        }
    }
    
    return result;
}

- (NSString *)appendReason:(NSString *)reason existingString:(NSString *)existing {
    if (existing.length > 700) {
        return existing;
    }
    
    NSString *result = existing.copy;
    
    if (!existing.length) {
        result = [result stringByAppendingString:@"The following fields are filled in incorrectly:\n"];
    }
    
    result = [result stringByAppendingFormat:@"\n%@;", reason];
    return result;
}

@end
