//
//  BFMSubviewsLayoutingView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/6/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSubviewsLayoutingView.h"

@implementation BFMSubviewsLayoutingView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *subview in self.subviews) {
        subview.frame = self.bounds;
    }
}

@end
