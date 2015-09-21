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

#import "UIColor+Extensions.h"

@interface BFMBenefitsController ()

@property (nonatomic, strong) UIPageViewController *pageController;

@end

@implementation BFMBenefitsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[self class], nil];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor bfm_defaultNavigationBlue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embed"]) {
        self.pageController = (UIPageViewController *)segue.destinationViewController;
        [self.pageController setViewControllers:[BFMBenefitsAdaptor startController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
