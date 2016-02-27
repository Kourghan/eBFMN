//
//  BFMFrontCardView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/10/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFMFrontCardDataProvider.h"

@interface BFMFrontCardView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *expirationLabel;
@property (nonatomic, weak) IBOutlet UILabel *codeLabel;
@property (nonatomic, weak) IBOutlet UIView *overlayView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topLogoConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorBotConstraint;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *adoptLabels;

- (void)configureWithDataProvider:(id<BFMFrontCardDataProvider>)provider;

@end
