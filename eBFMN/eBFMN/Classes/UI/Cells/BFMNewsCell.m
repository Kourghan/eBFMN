//
//  BFMNewsCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsCell.h"
#import "BFMNewsRecord.h"

@interface BFMNewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortTextLabel;


@end

@implementation BFMNewsCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _object = nil;
}

- (void)setObject:(BFMNewsRecord *)object {
    _object = object;
    
    self.titleLabel.text = _object.title;
    self.shortTextLabel.text = _object.shortText;
    self.dateLabel.text = [_object formattedDate];
}

@end
