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

#pragma mark - Property

- (void)setObject:(BFMPrize *)object {
    _object = object;
    self.nameLabel.text = object.name;
}

@end
