//
//  BFMBenefitsController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 20.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMBenefitsController.h"

#import "BFMBenefitsPageController.h"
#import "BFMBenefitsAdaptor.h"
#import "BFMGoalsAdapter.h"

#import "UIColor+Extensions.h"

@interface BFMBenefitsController ()

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) BFMGoalsAdapter *goalsAdapter;

@end

@implementation BFMBenefitsController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[self class], nil];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor bfm_defaultNavigationBlue];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embed"]) {
        self.pageController = (UIPageViewController *)segue.destinationViewController;
        switch (self.type) {
            case BFMProfileInfoTypeBenefits:
                [self.pageController setViewControllers:[BFMBenefitsAdaptor startController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                break;
            case BFMProfileInfoTypeGoals:
                _goalsAdapter = [[BFMGoalsAdapter alloc] initWithData:self.data];
                self.pageController.dataSource = _goalsAdapter;
                self.pageController.delegate = _goalsAdapter;
                
                [self.pageController setViewControllers:@[[_goalsAdapter silverPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                break;
            default:
                break;
        }
    }
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
