//
//  BFMBackCardView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMBackCardView.h"

@interface BFMBackCardView ()

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end

@implementation BFMBackCardView

- (void)configureWithDataProvider:(id<BFMBackCardDataProvider>)provider {
    self.backgroundImageView.image = [provider backCardBackgroundImage];
    self.titleLabel.text = [provider backCardTitleText];
    self.textLabel.text = [provider backCardContentText];
}

@end
