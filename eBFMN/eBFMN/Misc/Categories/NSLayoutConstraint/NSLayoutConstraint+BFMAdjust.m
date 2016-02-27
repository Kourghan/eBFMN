//
//  NSLayoutConstraint+BFMAdjust.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "NSLayoutConstraint+BFMAdjust.h"

BOOL bfm_isPhone4() {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat min = MIN(size.width, size.height);
    CGFloat max = MAX(size.width, size.height);
    return (max == 480.f) && (min == 320.f);
}

@implementation NSLayoutConstraint (BFMAdjust)

- (CGFloat)bfm_phone4Const {
    return self.constant;
}

- (void)setBfm_phone4Const:(CGFloat)bfm_phone4Const {
    if (bfm_isPhone4()) {
        self.constant = bfm_phone4Const;
    }
}

@end
