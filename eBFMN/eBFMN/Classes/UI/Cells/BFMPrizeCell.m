//
//  BFMPrizeCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPrizeCell.h"
#import "BFMPrize.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BFMPrizeCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *pointsLabel;
@property (nonatomic, weak) IBOutlet UIView *bgSelectionView;
@property (weak, nonatomic) IBOutlet UIImageView *prizeImage;
@property (weak, nonatomic) IBOutlet UIView *pointsView;
@property (weak, nonatomic) IBOutlet UIView *discountView;
@property (weak, nonatomic) IBOutlet UILabel *discountPriceLabel;

@end

@implementation BFMPrizeCell

#pragma mark - Override

- (void)prepareForReuse {
    [super prepareForReuse];
	
	self.pointsView.hidden = NO;
	self.discountView.hidden = YES;
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
	if ([object.prizeType integerValue] == BFMPrizeTypePlain) {
		if ([object.oldPoints integerValue] == 0) {
			self.pointsLabel.text = [object.points stringValue];
			self.discountView.hidden = YES;
		} else {
			self.discountView.hidden = NO;
			self.discountPriceLabel.text = [object.points stringValue];
			self.pointsLabel.text = [object.oldPoints stringValue];
			[UIView beginAnimations:nil context:NULL]; // arguments are optional
			[UIView setAnimationDuration:0];
			self.discountView.transform = CGAffineTransformMakeRotation(-45.f);
			[UIView commitAnimations];
		}
	} else {
		self.pointsView.hidden = YES;
	}
	
	
	
    self.nameLabel.text = object.name;
    NSURL *url = [NSURL URLWithString:[object.iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.prizeImage setImageWithURL:url
                    placeholderImage:[UIImage imageNamed:@"ic_prize1"]];
	
	
	
}

@end
