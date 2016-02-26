//
//  NSLayoutConstraint+SBFAdjust.m
//  sweetbrainfun
//
//  Created by Mykyta Shytik on 2/20/16.
//  Copyright © 2016 Mykyta Shytik. All rights reserved.
//

#import "NSLayoutConstraint+SBFAdjust.h"

#import "BFMUtils.h"

@implementation NSLayoutConstraint (SBFAdjust)

- (CGFloat)sbf_phone4 {
    return self.constant;
}

- (CGFloat)sbf_phone5 {
    return self.constant;
}

- (CGFloat)sbf_phone6 {
    return self.constant;
}

- (CGFloat)sbf_phone6P {
    return self.constant;
}

- (void)setSbf_phone4:(CGFloat)sbf_phone4 {
    if (sbf_isPhone4()) {
        self.constant = sbf_phone4;
    }
}

- (void)setSbf_phone5:(CGFloat)sbf_phone5 {
    if (sbf_isPhone5()) {
        self.constant = sbf_phone5;
    }
}

- (void)setSbf_phone6:(CGFloat)sbf_phone6 {
    if (sbf_isPhone6()) {
        self.constant = sbf_phone6;
    }
}

- (void)setSbf_phone6P:(CGFloat)sbf_phone6P {
    if (sbf_isPhone6P()) {
        self.constant = sbf_phone6P;
    }
}

@end
