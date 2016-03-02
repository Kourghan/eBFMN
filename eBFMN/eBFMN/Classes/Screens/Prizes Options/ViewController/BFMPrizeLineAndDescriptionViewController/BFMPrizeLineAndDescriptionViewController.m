//
//  BFMPrizeLineAndDescriptionViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeLineAndDescriptionViewController.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

@interface BFMPrizeLineAndDescriptionViewController ()

@end

@implementation BFMPrizeLineAndDescriptionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

@end
