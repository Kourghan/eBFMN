//
//  BFMBenefitsPageController.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 20.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMBenefitsPageController : UIViewController

- (void)setHTMLString:(NSString *)text title:(NSString *)title;

@property (nonatomic) NSUInteger index;

@end
