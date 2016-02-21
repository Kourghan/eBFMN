//
//  BFMBenefitsAdaptor.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 20.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMBenefitsAdaptor.h"
#import "BFMBenefitsPageController.h"
#import "BFMUtils.h"

const NSUInteger maxBenefitsPageIndex = 3;
const NSUInteger startBenefitsPageIndex = 0;

@interface BFMBenefitsAdaptor ()

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation BFMBenefitsAdaptor

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
    }
    return self;
}

- (BFMBenefitsPageController *)goldPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:0];
    NSString *webString = [self webStringFromString:[[self.data valueForKey:@"Gold"] firstObject]];
    [controller setHTMLString:webString title:NSLocalizedString(@"benefits.title.gold", nil)];
    
    return controller;
}

- (BFMBenefitsPageController *)platinumPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:1];
    NSString *webString = [self webStringFromString:[[self.data valueForKey:@"Platinum"] firstObject]];
    [controller setHTMLString:webString title:NSLocalizedString(@"benefits.title.platinum", nil)];
    
    return controller;
}

- (BFMBenefitsPageController *)diamandPage {
    BFMBenefitsPageController *controller = [self viewControllerAtIndex:2];
    NSString *webString = [self webStringFromString:[[self.data valueForKey:@"Diamond"] firstObject]];
    [controller setHTMLString:webString title:NSLocalizedString(@"benefits.title.diamand", nil)];
    
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
            return [self goldPage];
            break;
        case 1:
            return [self platinumPage];
            break;
        case 2:
            return [self diamandPage];
            break;
        default:
            return [self goldPage];
            break;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBenefitsPageController *)viewController index];
    
    
    index++;
    
    if (index == maxBenefitsPageIndex) {
        return nil;
    }
    
    return [self controllerForIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(BFMBenefitsPageController *)viewController index];
    
    if (index == startBenefitsPageIndex) {
        return nil;
    }
    
    index--;
    
    return [self controllerForIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (NSString *)webStringFromString:(NSString *)baseString {
    return bfm_webStringFromString(baseString);
}

@end
