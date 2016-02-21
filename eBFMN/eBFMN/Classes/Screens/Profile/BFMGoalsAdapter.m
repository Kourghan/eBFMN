//
//  BFMGoalsAdapter.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMGoalsAdapter.h"
#import "BFMBenefitsPageController.h"

const NSUInteger maxGoalsPageIndex = 4;
const NSUInteger startGoalsPageIndex = 0;

@interface BFMGoalsAdapter ()

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation BFMGoalsAdapter

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
    }
    return self;
}

- (BFMBenefitsPageController *)silverPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:0];
    [controller setHTMLString:[[self.data valueForKey:@"Silver"] firstObject] title:NSLocalizedString(@"benefits.title.silver", nil)];
    
    return controller;
}

- (BFMBenefitsPageController *)goldPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:1];
    [controller setHTMLString:[[self.data valueForKey:@"Gold"] firstObject] title:NSLocalizedString(@"benefits.title.gold", nil)];
    
    return controller;
}

- (BFMBenefitsPageController *)platinumPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:2];
    [controller setHTMLString:[[self.data valueForKey:@"Platinum"] firstObject] title:NSLocalizedString(@"benefits.title.platinum", nil)];
    
    return controller;
}

- (BFMBenefitsPageController *)diamandPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:3];
    [controller setHTMLString:[[self.data valueForKey:@"Diamond"] firstObject] title:NSLocalizedString(@"benefits.title.diamand", nil)];
    
    return controller;
}

- (BFMBenefitsPageController *)viewControllerAtIndex:(NSUInteger)index {
    
    BFMBenefitsPageController *childViewController = [[BFMBenefitsPageController alloc] initWithNibName:@"BFMBenefitsPageController" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
}

- (BFMBenefitsPageController *)controllerForIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [self silverPage];
        case 1:
            return [self goldPage];
        case 2:
            return [self platinumPage];
        case 3:
            return [self diamandPage];
        default:
            return [self silverPage];
            break;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBenefitsPageController *)viewController index];
    
    
    index++;
    
    if (index == maxGoalsPageIndex) {
        return nil;
    }
    
    return [self controllerForIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBenefitsPageController *)viewController index];
    
    if (index == startGoalsPageIndex) {
        return nil;
    }
    
    index--;
    
    return [self controllerForIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 4;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
