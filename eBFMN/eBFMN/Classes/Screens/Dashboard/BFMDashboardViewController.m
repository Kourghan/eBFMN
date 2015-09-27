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

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

@interface BFMDashboardViewController ()

@property (nonatomic, strong) UIPageViewController *pageController;

@end

@implementation BFMDashboardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    
    self.navigationItem.title = NSLocalizedString(@"dashboard.title", nil);
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

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
