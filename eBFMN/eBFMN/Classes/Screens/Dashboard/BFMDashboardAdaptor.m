//
//  BFMDashboardAdaptor.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMDashboardAdaptor.h"
#import "UIStoryboard+BFMStoryboards.h"
#import "BFMBasePageController.h"

@implementation BFMDashboardAdaptor

#pragma mark - PageViewController

+ (UIViewController *)initialControllerWithDelegate:(id<BFMEarningsPageDelegate>)delegate; {
	BFMBasePageController *controller = [[UIStoryboard dashboardStoryboard] instantiateViewControllerWithIdentifier:@"earningsPage"];
	controller.index = 0;
	if ([controller isKindOfClass:[BFMEarningsPage class]]) {
		[(BFMEarningsPage *)controller setDelegate:delegate];
	}
	
	return controller;
}


- (BFMBasePageController *)viewControllerAtIndex:(NSUInteger)index {
    BFMBasePageController *controller;
    switch (index) {
        case 0:
            controller = [[UIStoryboard dashboardStoryboard] instantiateViewControllerWithIdentifier:@"earningsPage"];
            break;
        case 1:
            controller = [[UIStoryboard dashboardStoryboard] instantiateViewControllerWithIdentifier:@"clientsPage"];
            break;
        default:
            return nil;
            break;
    }
    controller.index = index;
    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBasePageController *)viewController index];

    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBasePageController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
