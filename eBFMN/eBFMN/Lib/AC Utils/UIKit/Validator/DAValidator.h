//
// Created by Aleksey on 11.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAValidator : NSObject

typedef enum {
    DAValidationInvalid = 0,
    DAValidationValid = 1,
} DAValidationResult;

- (DAValidationResult)validate:(id)object;

+ (DAValidator *)emailValidator;
+ (DAValidator *)passwordValidator;
+ (DAValidator *)nameValidator;

@end