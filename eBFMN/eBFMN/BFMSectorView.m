//
//  BFMSectorView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/31/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMSectorView.h"

@implementation BFMSectorView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:213.f/255.f alpha:1.f].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:250.f/255.f alpha:1.f].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width - 1, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + 1, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + rect.size.width, rect.origin.y, rect.size.width - 1, M_PI, M_PI_4, 1);
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width - 1, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + 1, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + rect.size.width, rect.origin.y, rect.size.width - 1, M_PI, M_PI_4, 1);
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
}

@end
