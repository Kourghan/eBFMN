//
//  BFMFrontCardView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/10/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMFrontCardView.h"

static CGFloat const kBFMCardAdoptionScreeWidth = 320.f;
static CGFloat const kBFMAdoptedTopLogoConstant = 20.f;
static CGFloat const kBFMAdoptedSepTopConstant = 12.f;
static CGFloat const kBFMAdoptedSepBotConstant = 10.f;

@implementation BFMFrontCardView

#pragma mark - Override

- (void)awakeFromNib {
    [super awakeFromNib];
    [self adoptForSmallerScreenSizes];
}

#pragma mark - Public

- (void)configureWithDataProvider:(id<BFMFrontCardDataProvider>)provider {
    self.titleLabel.text = [provider frontCardTitleText];
    self.expirationLabel.text = [provider frontCardExpirationText];
    self.codeLabel.text = [provider frontCardCodeText];
}

#pragma mark - Private

- (void)adoptForSmallerScreenSizes {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (screenWidth <= kBFMCardAdoptionScreeWidth) {
        self.topLogoConstraint.constant = kBFMAdoptedTopLogoConstant;
        self.separatorTopConstraint.constant = kBFMAdoptedSepTopConstant;
        self.separatorBotConstraint.constant = kBFMAdoptedSepBotConstant;
        
        for (UILabel *label in self.adoptLabels) {
            label.font = [UIFont fontWithName:label.font.fontName
                                         size:label.font.pointSize - 1.f];
        }
    }
}
@end
