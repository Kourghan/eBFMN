//
//  BFMDashboardAdaptor.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BFMEarningsPage.h"

@interface BFMDashboardAdaptor : NSObject

+ (UIViewController *)initialControllerWithDelegate:(id<BFMEarningsPageDelegate>)delegate;

@end
