//
//  BFMNotificationCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 18.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNotificationCell.h"

#import "BFMNotification.h"

@interface BFMNotificationCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *datetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BFMNotificationCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _object = nil;
}

- (void)setObject:(BFMNotification *)object {
    _object = object;
    
    self.titleLabel.text = _object.title;
    self.contentLabel.text = _object.content;
    
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.frame);
    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
}

@end
