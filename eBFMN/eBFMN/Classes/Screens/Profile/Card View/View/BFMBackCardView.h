//
//  BFMBackCardView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMBackCardView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftConstr;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *rightConstr;
@property (nonatomic, weak) IBOutlet UIView *overlayView;

- (void)updateAsGoal:(BOOL)isGoal;

@end
