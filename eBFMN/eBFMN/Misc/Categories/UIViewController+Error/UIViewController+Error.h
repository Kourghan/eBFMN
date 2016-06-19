//
//  UIViewController+Error.h
//  eBFMN
//
//  Created by Mykyta Shytik on 5/25/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Error)

- (void)bfm_showError;
- (void)bfm_showErrorInKW:(NSString *)title subtitle:(NSString *)subtitle;
- (void)bfm_showErrorInOW:(NSString *)title subtitle:(NSString *)subtitle;
- (void)bfm_showErrorInKW:(NSString *)title
                 subtitle:(NSString *)subtitle
                 duration:(NSTimeInterval)ti;
- (void)bfm_showErrorInOW:(NSString *)title
                 subtitle:(NSString *)subtitle
                 duration:(NSTimeInterval)ti;
- (void)bfm_showErrorInView:(UIView *)view
                      title:(NSString *)title
                   subtitle:(NSString *)subtitle
                   duration:(NSTimeInterval)duration;

@end
