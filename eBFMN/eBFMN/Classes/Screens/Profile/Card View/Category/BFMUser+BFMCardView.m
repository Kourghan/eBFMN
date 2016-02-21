//
//  BFMUser+BFMCardView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMUser+BFMCardView.h"

@implementation BFMUser (BFMCardView)

- (NSString *)frontCardTitleText {
    return self.name.uppercaseString;
}

- (NSString *)frontCardExpirationText {
    return @"Expiration Date: 10/17";
}

- (NSString *)frontCardCodeText {
    return [NSString stringWithFormat:@"Code: %@", self.code];
}

@end
