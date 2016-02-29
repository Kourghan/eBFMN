//
//  BFMPrizeBannerCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeBannerCell.h"
#import "BFMBanner.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BFMPrizeBannerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;

@end

@implementation BFMPrizeBannerCell

- (void)prepareForReuse {
	[super prepareForReuse];
	
	_object = nil;
}

#pragma mark - Property

- (void)setObject:(BFMBanner *)object {
	_object = object;
	NSURL *url = [NSURL URLWithString:[object.link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[self.bannerImageView setImageWithURL:url
						 placeholderImage:[UIImage imageNamed:@"ic_prize1"]];
}

@end
