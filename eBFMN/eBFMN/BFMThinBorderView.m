//
//  BFMThinBorderView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/31/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMThinBorderView.h"

@implementation BFMThinBorderView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:213.f/255.f alpha:1.f].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, rect.size.width, 0.5f));
    CGContextFillRect(ctx, CGRectMake(0, 0, 0.5f, rect.size.height));
    CGContextFillRect(ctx, CGRectMake(0, rect.size.height - 0.5f, rect.size.width, 0.5f));
    CGContextFillRect(ctx, CGRectMake(rect.size.width - 0.5f, 0, 0.5f, rect.size.height));
}

@end
