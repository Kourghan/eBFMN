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

@interface BFMFrontCardView ()

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *expirationLabel;
@property (nonatomic, weak) IBOutlet UILabel *codeLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topLogoConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorBotConstraint;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *adoptLabels;

@end

@implementation BFMFrontCardView

#pragma mark - Override

- (void)awakeFromNib {
    [super awakeFromNib];
    [self adoptForSmallerScreenSizes];
}

#pragma mark - Public

- (void)configureWithDataProvider:(id<BFMFrontCardDataProvider>)provider {
    self.backgroundImageView.image = [provider frontCardBackgroundImage];
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
