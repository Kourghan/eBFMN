//
//  BFMFirstLayoutView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/15/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMFirstLayoutView.h"

@implementation BFMFirstLayoutView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        view.frame = self.bounds;
    }
}

@end
