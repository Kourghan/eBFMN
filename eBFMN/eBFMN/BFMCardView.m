//
//  BFMCardView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/10/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMCardView.h"

static CGFloat const kBFMCardAdoptionScreeWidth = 320.f;
static CGFloat const kBFMAdoptedTopLogoConstant = 20.f;
static CGFloat const kBFMAdoptedSepTopConstant = 12.f;
static CGFloat const kBFMAdoptedSepBotConstant = 10.f;

@interface BFMCardView ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topLogoConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorBotConstraint;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *adoptLabels;

@end

@implementation BFMCardView

#pragma mark - Override

- (void)awakeFromNib {
    [super awakeFromNib];
    [self adoptForSmallerScreenSizes];
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
