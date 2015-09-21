//
//  BFMBenefitsAdaptor.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 20.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMBenefitsAdaptor.h"

#import "BFMBenefitsPageController.h"

const NSUInteger maxPageIndex = 2;
const NSUInteger startPageIndex = 0;

@implementation BFMBenefitsAdaptor

#pragma mark - PageViewController

+ (NSArray *)startController {
    return @[[self fisrtPage]];
}

+ (BFMBenefitsPageController *)fisrtPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:0];
    [controller setHTMLString:NSLocalizedString(@"benefits.gold", nil) title:NSLocalizedString(@"benefits.title.gold", nil)];
    
    return controller;
}

+ (BFMBenefitsPageController *)secondPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:1];
    [controller setHTMLString:NSLocalizedString(@"benefits.diamond", nil) title:NSLocalizedString(@"benefits.title.diamond", nil)];
    
    return controller;
}

+ (BFMBenefitsPageController *)thirdPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:2];
    [controller setHTMLString:NSLocalizedString(@"benefits.gold", nil) title:NSLocalizedString(@"benefits.title.gold", nil)];
    
    return controller;
}

+ (BFMBenefitsPageController *)lastPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:3];
    [controller setHTMLString:NSLocalizedString(@"benefits.gold", nil) title:NSLocalizedString(@"benefits.title.gold", nil)];
    
    return controller;
}

+ (BFMBenefitsPageController *)viewControllerAtIndex:(NSUInteger)index {
    
    BFMBenefitsPageController *childViewController = [[BFMBenefitsPageController alloc] initWithNibName:@"BFMBenefitsPageController" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
}

- (BFMBenefitsPageController *)controllerForIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [BFMBenefitsAdaptor fisrtPage];
        case 1:
            return [BFMBenefitsAdaptor secondPage];
        case 2:
            return [BFMBenefitsAdaptor thirdPage];
        case 3:
            return [BFMBenefitsAdaptor lastPage];
        default:
            return [BFMBenefitsAdaptor fisrtPage];
            break;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBenefitsPageController *)viewController index];
    
    
    index++;
    
    if (index == maxPageIndex) {
        return nil;
    }
    
    return [self controllerForIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBenefitsPageController *)viewController index];
    
    if (index == startPageIndex) {
        return nil;
    }
    
    index--;
    
    return [self controllerForIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return maxPageIndex;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return startPageIndex;
}

@end
