//
//  BFMPrizeCategoryCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategoryCell.h"
#import "BFMPrizeCategory.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BFMPrizeCategoryCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIView *bgSelectionView;
@property (weak, nonatomic) IBOutlet UIImageView *prizeImage;

@end

@implementation BFMPrizeCategoryCell

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
//	UIColor *color1 = [UIColor colorWithRed:220.f / 255.f
//									  green:222.f / 255.f
//									   blue:242.f / 255.f
//									  alpha:1.f];
//	UIColor *color2 = [UIColor whiteColor];
//	self.bgSelectionView.backgroundColor = selected ? color1 : color2;
}

#pragma mark - Property

- (void)setObject:(BFMPrizeCategory *)object {
	_object = object;
	self.nameLabel.text = object.name;
	NSURL *url = [NSURL URLWithString:[object.link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[self.prizeImage setImageWithURL:url
					placeholderImage:[UIImage imageNamed:@"ic_prize1"]];
}

@end
