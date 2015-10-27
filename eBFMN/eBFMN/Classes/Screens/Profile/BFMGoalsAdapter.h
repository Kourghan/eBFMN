//
//  BFMGoalsAdapter.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BFMBenefitsPageController;

@interface BFMGoalsAdapter : NSObject <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

- (instancetype)initWithData:(NSDictionary *)data;

- (BFMBenefitsPageController *)silverPage;
- (BFMBenefitsPageController *)goldPage;
- (BFMBenefitsPageController *)platinumPage;
- (BFMBenefitsPageController *)diamandPage;

@end
