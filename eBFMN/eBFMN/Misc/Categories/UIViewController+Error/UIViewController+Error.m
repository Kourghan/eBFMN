//
//  UIViewController+Error.m
//  eBFMN
//
//  Created by Mykyta Shytik on 5/25/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "UIViewController+Error.h"
#import "UIView+Toast.h"

@implementation UIViewController (Error)

- (void)bfm_showError {
    [self bfm_showErrorInKW:NSLocalizedString(@"error.error", nil)
                   subtitle:NSLocalizedString(@"error.connection", nil)];
}

- (void)bfm_showErrorInKW:(NSString *)title subtitle:(NSString *)subtitle {
    [self bfm_showErrorInKW:title subtitle:subtitle duration:1.5];
}

- (void)bfm_showErrorInOW:(NSString *)title subtitle:(NSString *)subtitle {
    [self bfm_showErrorInOW:title subtitle:subtitle duration:1.5];
}

- (void)bfm_showErrorInKW:(NSString *)title
                 subtitle:(NSString *)subtitle
                 duration:(NSTimeInterval)ti {
    [self bfm_showErrorInView:[UIApplication sharedApplication].keyWindow
                        title:title
                     subtitle:subtitle
                     duration:ti];
}

- (void)bfm_showErrorInOW:(NSString *)title
                 subtitle:(NSString *)subtitle
                 duration:(NSTimeInterval)ti {
    [self bfm_showErrorInView:self.view.window
                        title:title
                     subtitle:subtitle
                     duration:ti];
}

- (void)bfm_showErrorInView:(UIView *)view
                      title:(NSString *)title
                   subtitle:(NSString *)subtitle
                   duration:(NSTimeInterval)duration {
    [view makeToast:subtitle
           duration:duration
           position:nil
              title:title
              image:nil
              style:nil
         completion:nil];
}

@end
