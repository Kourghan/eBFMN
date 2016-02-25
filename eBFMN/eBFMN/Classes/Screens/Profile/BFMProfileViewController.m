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
#import "BFMPointsRecord.h"
#import "BFMNewsRecord.h"

#import "BFMProfileCardDataController.h"
#import "JNKeychain+UNTExtension.h"
#import "BFMBenefitsController.h"

#import "BFMCardPresentingView.h"
#import "BFMUser+BFMCardView.h"
#import "BFMFrontCardView.h"
#import "BFMBackCardView.h"
#import "UIView+BFMLoad.h"
#import "BFMSessionManager.h"

#import <MagicalRecord/MagicalRecord.h>

#define BFM_CARD_CON BFMProfileCardDataController

@interface BFMProfileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *benefitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIImageView *leagueImageView;

@property (weak, nonatomic) IBOutlet BFMCardPresentingView *cardPresentingView;
@property (weak, nonatomic) IBOutlet BFMCardPresentingView *goalCardView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *goalsViews;

@end

@implementation BFMProfileViewController

#pragma mark - Memory management

- (void)dealloc {
    [self unsubscribeLogoutNotification];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIView *view in self.goalsViews) {
        view.hidden = YES;
    }
    self.cardPresentingView.hidden = YES;
    
    [self subscribeLogoutNotification];
    [self bindUser:[BFMUser currentUser]];
    [self setupCardPresentingView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    
    [self loadLeague];
    [self loadBenefits];
    [self loadGoals];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - NSNotification Handling

- (void)subscribeLogoutNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleLogoutNotification:)
                                                 name:kBFMLogoutNotification
                                               object:nil];
}

- (void)unsubscribeLogoutNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleLogoutNotification:(NSNotification *)notif {
    [self logout:nil];
}

#pragma mark - Private (Setup)

- (void)setupCardPresentingView {
    {
        BFMCardPresentingView *presView = self.cardPresentingView;
        BFMFrontCardView *frontView = [BFMFrontCardView bfm_load];
        [frontView configureWithDataProvider:[BFMUser currentUser]];
        [presView setupView:frontView side:BFMCardPresentingViewSideFront];
        BFMBackCardView *backView = [BFMBackCardView bfm_load];
        [presView setupView:backView side:BFMCardPresentingViewSideBack];
        [presView showSide:BFMCardPresentingViewSideFront animated:NO];
    }
    
    {
        BFMCardPresentingView *presView = self.goalCardView;
        BFMFrontCardView *frontView = [BFMFrontCardView bfm_load];
        [frontView configureWithDataProvider:[BFMUser currentUser]];
        [presView setupView:frontView side:BFMCardPresentingViewSideFront];
        BFMBackCardView *backView = [BFMBackCardView bfm_load];
        [presView setupView:backView side:BFMCardPresentingViewSideBack];
        [presView showSide:BFMCardPresentingViewSideFront animated:NO];
    }
}

#pragma mark - Private

- (void)loadLeague {
    __weak typeof(self) weakSelf = self;
    BFMUser *user = [BFMUser currentUser];
    [user getIBLeagueWithCompletitionBlock:^(BFMLeagueType type,
                                             NSError *error) {
        if (!error) {
            [weakSelf bindType:type];
        }
    }];
}

- (void)bindUser:(BFMUser *)user {
    self.navigationItem.title = NSLocalizedString(@"profile.title", nil);
    self.benefitsLabel.text = NSLocalizedString(@"profile.benefits", nil);
    self.goalsLabel.text = NSLocalizedString(@"profile.goals", nil);
    [self.logoutButton setTitle:NSLocalizedString(@"profile.logout", nil) forState:UIControlStateNormal];
    
    self.usernameLabel.text = user.name;
    self.idLabel.text = [user.code stringValue];
}

- (void)bindType:(BFMLeagueType)type {
    [BFMProfileCardDataController setCurrentType:type];
    [self updateUI];
}

- (void)updateUI {
    {
        UIImage *frontImage = [BFM_CARD_CON imageForCurrentType:NO];
        UIImage *backImage = [BFM_CARD_CON imageForCurrentType:YES];
        NSString *benefitTitle = [BFM_CARD_CON backHeaderForCurrentType];
        NSAttributedString *benefitText = [BFM_CARD_CON benefitsTextForCurrentLeague];
        
        BFMCardPresentingView *presView = self.cardPresentingView;
        
        BFMFrontCardView *frontCard = (id)presView.frontView;
        [frontCard configureWithDataProvider:[BFMUser currentUser]];
        frontCard.backgroundImageView.image = frontImage;
        
        BFMBackCardView *backCard = (id)presView.backView;
        backCard.backgroundImageView.image = backImage;
        backCard.titleLabel.text = benefitTitle;
        
        backCard.textLabel.adjustsFontSizeToFitWidth = true;
        backCard.textLabel.attributedText = benefitText;
        backCard.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [backCard updateAsGoal:NO];
        
        presView.hidden = ([BFM_CARD_CON currentType] == BFMLeagueTypeUndefined);
    }
    
    {
        UIImage *frontImage = [BFM_CARD_CON imageForNextType:NO];
        UIImage *backImage = [BFM_CARD_CON imageForNextType:YES];
        NSString *benefitTitle = [BFM_CARD_CON backHeaderForNextType];
        NSString *goalText = [BFM_CARD_CON goalsTextForNextLeague];
        
        BFMCardPresentingView *presView = self.goalCardView;
        
        BFMFrontCardView *frontCard = (id)presView.frontView;
        [frontCard configureWithDataProvider:[BFMUser currentUser]];
        frontCard.backgroundImageView.image = frontImage;
        
        BFMBackCardView *backCard = (id)presView.backView;
        backCard.backgroundImageView.image = backImage;
        backCard.titleLabel.text = benefitTitle;
        
        backCard.textLabel.adjustsFontSizeToFitWidth = true;
        backCard.textLabel.text = goalText;
        backCard.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [backCard updateAsGoal:YES];
        
        BOOL shouldShow = [BFM_CARD_CON shouldShowNextType];
        for (UIView *goalView in self.goalsViews) {
            goalView.hidden = !shouldShow;
        }
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
    
    NSArray *points = [BFMPointsRecord MR_findAll];
    for (BFMPointsRecord *record in points) {
        [record MR_deleteEntityInContext:context];
    }
    
    NSArray *news = [BFMNewsRecord MR_findAll];
    for (BFMNewsRecord *record in news) {
        [record MR_deleteEntityInContext:context];
    }
    
    [context MR_saveToPersistentStoreAndWait];
    
    [BFMProfileCardDataController clear];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void)loadBenefits {
    [BFMUser getAllIBLeagueBenefits:^(NSDictionary *leagues, NSError *error) {
        [BFMProfileCardDataController setBenefits:leagues];
        [self updateUI];
    }];
}

- (void)loadGoals {
    [BFMUser getAllIBLeagueGoals:^(NSDictionary *leagues, NSError *error) {
        [BFMProfileCardDataController setGoals:leagues];
        [self updateUI];
    }];
}

#pragma mark - IBAction

- (IBAction)swapButtonTap {
    [self.cardPresentingView switchSide];
}

- (IBAction)goalSwapButtonTap {
    [self.goalCardView switchSide];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goals"]) {
        BFMBenefitsController *controller = (BFMBenefitsController *)[segue destinationViewController];
        controller.type = BFMProfileInfoTypeGoals;
        controller.data = sender;
    } else if ([segue.identifier isEqualToString:@"benefits"]) {
        BFMBenefitsController *controller = (BFMBenefitsController *)[segue destinationViewController];
        controller.type = BFMProfileInfoTypeBenefits;
        controller.data = sender;
    }
}


@end
