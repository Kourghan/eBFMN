//
//  UITextField+BFMPlaceholderColor.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "UITextField+BFMPlaceholderColor.h"

@implementation UITextField (BFMPlaceholderColor)

- (void)bfm_whitify {
    NSDictionary *attr = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder
                                                                 attributes:attr];
}

@end
