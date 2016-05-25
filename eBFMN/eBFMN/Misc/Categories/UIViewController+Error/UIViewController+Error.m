//
//  UIViewController+Error.m
//  eBFMN
//
//  Created by Mykyta Shytik on 5/25/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "UIViewController+Error.h"
#import <ALAlertBanner/ALAlertBanner.h>

@implementation UIViewController (Error)

- (void)bfm_showError {
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:[UIApplication sharedApplication].keyWindow
                                                        style:ALAlertBannerStyleFailure
                                                     position:ALAlertBannerPositionTop
                                                        title:NSLocalizedString(@"error.error", nil)
                                                     subtitle:NSLocalizedString(@"error.connection", nil)];
    [banner show];
}

@end
