//
//  BFMBackCardView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMBackCardView.h"

@implementation BFMBackCardView

- (void)configureWithDataProvider:(id<BFMBackCardDataProvider>)provider {
    self.backgroundImageView.image = [provider backCardBackgroundImage];
    self.titleLabel.text = [provider backCardTitleText];
    self.textLabel.text = [provider backCardContentText];
}

@end
