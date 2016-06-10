//
//  UIViewController+Error.m
//  eBFMN
//
//  Created by Mykyta Shytik on 5/25/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "UIViewController+Error.h"
#import <CRToast/CRToast.h>

@implementation UIViewController (Error)

- (void)bfm_showError {
    [self bfm_showErrorInKW:NSLocalizedString(@"error.error", nil)
                   subtitle:NSLocalizedString(@"error.connection", nil)];
}

- (void)bfm_showErrorInKW:(NSString *)title subtitle:(NSString *)subtitle {
    [self bfm_showErrorInView:[UIApplication sharedApplication].keyWindow
                        title:title
                     subtitle:subtitle];
}

- (void)bfm_showErrorInOW:(NSString *)title subtitle:(NSString *)subtitle {
    [self bfm_showErrorInView:self.view.window
                        title:title
                     subtitle:subtitle];
}

- (void)bfm_showErrorInView:(UIView *)view title:(NSString *)title subtitle:(NSString *)subtitle {
    NSDictionary *config = @{
                             kCRToastFontKey: [UIFont fontWithName:@"ProximaNova-Semibold" size:14.f],
                             kCRToastSubtitleFontKey: [UIFont fontWithName:@"ProximaNova-Semibold" size:12.f],
                             kCRToastTextAlignmentKey: @(NSTextAlignmentLeft),
                             kCRToastSubtitleTextAlignmentKey: @(NSTextAlignmentLeft),
                             kCRToastBackgroundColorKey: [UIColor redColor],
                             kCRToastTextColorKey: [UIColor whiteColor],
                             kCRToastSubtitleTextColorKey: [UIColor whiteColor],
                             kCRToastNotificationTypeKey: @(CRToastTypeNavigationBar),
                             kCRToastTextKey: title,
                             kCRToastSubtitleTextKey: subtitle
                             };
    [CRToastManager showNotificationWithOptions:config completionBlock:nil];
}

@end
