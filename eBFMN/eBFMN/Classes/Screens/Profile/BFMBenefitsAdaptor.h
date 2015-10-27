//
//  BFMBenefitsAdaptor.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 20.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class BFMBenefitsPageController;

@interface BFMBenefitsAdaptor : NSObject <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

- (instancetype)initWithData:(NSDictionary *)data;

- (BFMBenefitsPageController *)goldPage;
- (BFMBenefitsPageController *)platinumPage;
- (BFMBenefitsPageController *)diamandPage;

@end