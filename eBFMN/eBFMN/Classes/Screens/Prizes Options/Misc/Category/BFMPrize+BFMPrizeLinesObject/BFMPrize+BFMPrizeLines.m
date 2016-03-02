//
//  BFMPrize+BFMPrizeLines.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrize+BFMPrizeLines.h"

#import <UIKit/UIKit.h>

@implementation BFMPrize (BFMPrizeLines)

- (UIColor *)bfm_color {
    return [UIColor darkGrayColor];
}

- (BOOL)bfm_isFill {
    return NO;
}

- (NSString *)bfm_title {
    return self.name;
}

@end
