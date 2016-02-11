//
//  BFMUser+BFMCardView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMUser+BFMCardView.h"

@implementation BFMUser (BFMCardView)

- (UIImage *)frontCardBackgroundImage {
    return [UIImage imageNamed:@"platinum"];
}

- (NSString *)frontCardTitleText {
    return self.name.uppercaseString;
}

- (NSString *)frontCardExpirationText {
    return @"Expiration Date: 10/17";
}

- (NSString *)frontCardCodeText {
    return [NSString stringWithFormat:@"Code: %@", self.code];
}

- (UIImage *)backCardBackgroundImage {
    return [UIImage imageNamed:@"platinumback"];
}

- (NSString *)backCardTitleText {
    return nil;
}

- (NSString *)backCardContentText {
    return nil;
}

@end
