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

#import "UIColor+Extensions.h"
#import "UIStoryboard+BFMStoryboards.h"
#import "BFMUser+Extension.h"

#import "BFMPrizeCategorisController.h"

@interface BFMDashboardViewController ()

@property (nonatomic, strong) UIPageViewController *pageController;

@end

@implementation BFMDashboardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    
    self.navigationItem.title = NSLocalizedString(@"dashboard.title", nil);
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - Protocol

- (void)showPrizes {
	BFMPrizeCategorisController *categories = [[UIStoryboard prizesStoryboard] instantiateViewControllerWithIdentifier:@"categories"];
	[self.navigationController pushViewController:categories animated:YES];
}

#pragma mark - Network

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embed"]) {
        self.pageController = (UIPageViewController *)segue.destinationViewController;
        
        NSArray *subviews = self.pageController.view.subviews;
        UIPageControl *thisControl = nil;
        for (int i = 0; i < [subviews count]; i++) {
            if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
                thisControl = (UIPageControl *)[subviews objectAtIndex:i];
            }
        }
        
        thisControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        thisControl.currentPageIndicatorTintColor = [UIColor bfm_defaultNavigationBlue];
			
        [self.pageController setViewControllers:@[[BFMDashboardAdaptor initialControllerWithDelegate:self]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    }
}

@end
