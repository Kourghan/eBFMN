//
//  BFMProfileViewController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 15.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMProfileViewController.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

#import "BFMUser+Extension.h"
#import "JNKeychain+UNTExtension.h"

#import <MagicalRecord/MagicalRecord.h>

@interface BFMProfileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *benefitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation BFMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"profile.title", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - Handlers

- (IBAction)logout:(id)sender {
    [JNKeychain deleteValueForKey:kBFMSessionKey];
    
    [BFMUser MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"identifier != 0"] inContext:[NSManagedObjectContext MR_defaultContext]];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (IBAction)benefits:(UIButton *)sender {
}

- (IBAction)goals:(UIButton *)sender {
}



@end
