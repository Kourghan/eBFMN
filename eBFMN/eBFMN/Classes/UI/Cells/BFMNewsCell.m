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


@end

@implementation BFMNewsCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _object = nil;
}

- (void)setObject:(BFMNewsRecord *)object {
    _object = object;
    
    self.titleLabel.text = _object.title;
//    self.dateLabel.text = []
}

@end
