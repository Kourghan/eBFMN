//
//  BFMPrizeCategoryCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategoryCell.h"
#import "BFMPrizeCategory.h"

#import <SDWebImage/UIImageView+WebCache.h>

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

#pragma mark - Property

- (void)setObject:(BFMPrizeCategory *)object {
	_object = object;
	self.nameLabel.text = object.name;
	NSURL *url = [NSURL URLWithString:[object.link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[self.prizeImage sd_setImageWithURL:url
					   placeholderImage:[UIImage imageNamed:@"ic_prize_placeholder"]];
}

@end
