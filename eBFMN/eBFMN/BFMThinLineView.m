//
//  BFMThinLineView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 4/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMThinLineView.h"

@implementation BFMThinLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:8.f/255.f green:69.f/255.f blue:110.f/255.f alpha:1.f].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, rect.size.width, 0.5f));
}

@end
