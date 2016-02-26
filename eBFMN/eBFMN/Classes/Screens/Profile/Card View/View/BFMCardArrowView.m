//
//  BFMCardArrowView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/24/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMCardArrowView.h"
#import "BFMUtils.h"

static CGFloat const kBFMCardArrowW = 35.f;
static CGFloat const kBFMCardArrowH = 8.f;

@implementation BFMCardArrowView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat arrY = maxY - kBFMCardArrowH;
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, minX, minY);
    CGContextAddLineToPoint(ctx, maxX, minY);
    CGContextAddLineToPoint(ctx, maxX, arrY);
    CGContextAddLineToPoint(ctx, midX + kBFMCardArrowW, arrY);
    CGContextAddLineToPoint(ctx, midX, maxY);
    CGContextAddLineToPoint(ctx, midX - kBFMCardArrowW, arrY);
    CGContextAddLineToPoint(ctx, midX - kBFMCardArrowW, arrY);
    CGContextAddLineToPoint(ctx, minX, arrY);
    CGContextAddLineToPoint(ctx, minX, minY);
    CGContextClosePath(ctx);
    
    CGContextSetRGBFillColor(ctx, 6.f/255.f, 69.f/255.f, 109.f/255.f, 1);
    CGContextFillPath(ctx);
}

@end
