//
//  BFMPrizeLinesCell.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeLinesCell.h"

@interface BFMPrizeLinesCell ()

@property (nonatomic, weak) IBOutlet UIImageView *selectImageView;
@property (nonatomic, weak) IBOutlet UILabel *selectTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *checkMarkImageView;
@property (nonatomic, weak) IBOutlet UIView *rightSepView;
@property (nonatomic, weak) IBOutlet UIView *bottomSepView;

@end

@implementation BFMPrizeLinesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureWithObject:(id<BFMPrizeLinesObject>)object
                   selected:(BOOL)selected
                    outline:(BOOL)outline {
    
    if (selected) {
        UIColor *selectedColor = [UIColor colorWithRed:108.f/255.f
                                                 green:163.f/255.f
                                                  blue:51.f/255.f
                                                 alpha:1.f];
        self.selectImageView.backgroundColor = selectedColor;
        self.selectImageView.layer.borderColor = selectedColor.CGColor;
        self.selectImageView.layer.borderWidth = 2.f;
        self.checkMarkImageView.image = [UIImage imageNamed:@"ic_save"];
    } else if (!outline) {
        UIColor *selectedColor = [object bfm_color];
        self.selectImageView.backgroundColor = selectedColor;
        self.selectImageView.layer.borderColor = selectedColor.CGColor;
        self.selectImageView.layer.borderWidth = 2.f;
        self.checkMarkImageView.image = nil;
    } else {
        UIColor *selectedColor = [object bfm_color];
        self.selectImageView.backgroundColor = [UIColor clearColor];
        self.selectImageView.layer.borderColor = selectedColor.CGColor;
        self.selectImageView.layer.borderWidth = 2.f;
        self.checkMarkImageView.image = nil;
    }
    
    self.selectTitleLabel.text = [object bfm_title];
}

- (void)showBottomLine:(BOOL)showBottom showRightLine:(BOOL)showRight {
    self.rightSepView.hidden = !showRight;
    self.bottomSepView.hidden = !showBottom;
}

@end
