//
//  BFMPrize2LinesViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrize2LinesViewController.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

@interface BFMPrize2LinesViewController ()

@end

@implementation BFMPrize2LinesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

@end
