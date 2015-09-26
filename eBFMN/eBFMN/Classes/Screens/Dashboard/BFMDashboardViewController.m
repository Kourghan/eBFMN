//
//  BFMDashboardViewController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMDashboardViewController.h"
#import "BFMEarningsPage.h"
#import "BFMDashboardAdaptor.h"

@interface BFMDashboardViewController ()

@property (nonatomic, strong) UIPageViewController *pageController;

@end

@implementation BFMDashboardViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embed"]) {
        self.pageController = (UIPageViewController *)segue.destinationViewController;
        [self.pageController setViewControllers:@[[BFMDashboardAdaptor initialController]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    }
}

@end
