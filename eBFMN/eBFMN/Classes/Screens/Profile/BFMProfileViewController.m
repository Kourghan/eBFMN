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
@property (weak, nonatomic) IBOutlet UIImageView *leagueImageView;

@end

@implementation BFMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindUser:[BFMUser currentUser]];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [[BFMUser currentUser] getIBLeagueWithCompletitionBlock:^(BFMLeagueType type, NSError *error) {
        if (!error) {
            [weakSelf bindType:type];
        }
    }];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - private

- (void)bindUser:(BFMUser *)user {
    self.navigationItem.title = NSLocalizedString(@"profile.title", nil);
    self.benefitsLabel.text = NSLocalizedString(@"profile.benefits", nil);
    self.goalsLabel.text = NSLocalizedString(@"profile.goals", nil);
    [self.logoutButton setTitle:NSLocalizedString(@"profile.logout", nil) forState:UIControlStateNormal];
    
    self.usernameLabel.text = user.name;
    self.idLabel.text = [user.code stringValue];
}

- (void)bindType:(BFMLeagueType)type {
    UIImage *image;
    
    switch (type) {
        case BFMLeagueTypeSilver:
            image = [UIImage imageNamed:@"ic_silver"];
            break;
        case BFMLeagueTypeGold:
            image = [UIImage imageNamed:@"ic_gold"];
            break;
        case BFMLeagueTypePlatinum:
            image = [UIImage imageNamed:@"ic_platinum"];
            break;
        case BFMLeagueTypeDiamand:
            image = [UIImage imageNamed:@"ic_diamand"];
            break;
        default:
            break;
    }
    
    if (image) {
        self.leagueImageView.image = image;
    }
}

#pragma mark - Handlers

- (IBAction)logout:(id)sender {
    [JNKeychain deleteValueForKey:kBFMSessionKey];
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSArray *users = [BFMUser MR_findAll];
    for (BFMUser *user in users) {
        [user MR_deleteEntityInContext:context];
    }
    
    [context MR_saveToPersistentStoreAndWait];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (IBAction)benefits:(UIButton *)sender {
    [BFMUser getAllIBLeagueBenefits:^(NSArray *leagues) {
        
    }];
}

- (IBAction)goals:(UIButton *)sender {
    [BFMUser getAllIBLeagueGoals:^(NSArray *leagues) {
        
    }];
}



@end
