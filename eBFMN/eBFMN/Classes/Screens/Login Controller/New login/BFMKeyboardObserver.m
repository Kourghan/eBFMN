//
//  BFMKeyboardObserver.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMKeyboardObserver.h"

@implementation BFMKeyboardObserver

#pragma mark - Memory managent

- (void)dealloc {
    [self baseKeyboardUnsubscribe];
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self baseKeyboardSubscribe];
    }
    return self;
}

#pragma mark - KVO

- (void)baseKeyboardSubscribe {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveKeyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveKeyboardNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)baseKeyboardUnsubscribe {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveKeyboardNotification:(NSNotification *)aNotification {
    NSString *name = aNotification.name;
    BOOL willShow = [name isEqualToString:UIKeyboardWillShowNotification];
    BOOL willHide = [name isEqualToString:UIKeyboardWillHideNotification];
    self.kbVisible = willShow;
    if (willShow || willHide) {
        NSDictionary *userInfo = aNotification.userInfo;
        CGRect keyboardRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardHeight = willShow ? CGRectGetHeight(keyboardRect) : 0.f;
        NSTimeInterval timeInterval = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        if ([self.delegate respondsToSelector:@selector(keyboardObserver:animateKeyboardHeight:duration:curve:)]) {
            [self.delegate keyboardObserver:self
                      animateKeyboardHeight:keyboardHeight
                                   duration:timeInterval
                                      curve:curve];
        }
    }
}

@end

