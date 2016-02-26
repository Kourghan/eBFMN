//
//  BFMBackCardView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMBackCardView.h"

static CGFloat const kBFMBenefitSideMargin = 22.f;

@implementation BFMBackCardView

- (void)updateAsGoal:(BOOL)isGoal {
    CGFloat constant = kBFMBenefitSideMargin;
    self.leftConstr.constant = constant;
    self.rightConstr.constant = constant;
}

@end
