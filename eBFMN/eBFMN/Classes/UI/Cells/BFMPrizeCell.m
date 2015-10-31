//
//  BFMPrizeCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPrizeCell.h"
#import "BFMPrize.h"

@interface BFMPrizeCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *pointsLabel;
@property (nonatomic, weak) IBOutlet UIView *bgSelectionView;
@property (weak, nonatomic) IBOutlet UIImageView *prizeImage;

@end

@implementation BFMPrizeCell

#pragma mark - Override

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _object = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Public

- (void)configureSelected:(BOOL)selected {
    UIColor *color1 = [UIColor colorWithRed:220.f / 255.f
                                      green:222.f / 255.f
                                       blue:242.f / 255.f
                                      alpha:1.f];
    UIColor *color2 = [UIColor whiteColor];
    self.bgSelectionView.backgroundColor = selected ? color1 : color2;
}

#pragma mark - Property

- (void)setObject:(BFMPrize *)object {
    _object = object;
    self.nameLabel.text = object.name;
    self.pointsLabel.text = [object.points stringValue];
}

@end
