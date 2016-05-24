//
//  BFMPrizeCategorisController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategorisController.h"
#import "BFMPrizeCategoriesViewModel.h"
#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"
#import "BFMPrizeCategoriesAdapter.h"
#import "BFMPrizeCategory.h"
#import "BFMPrize.h"
#import "BFMPrizeBannerAdapter.h"
#import "BFMBanner.h"
#import "BFMPrize2LinesViewController.h"
#import "BFMPrizeLineAndDescriptionViewController.h"
#import "BFMPrize2LinesViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIViewController+Error.h"


#import "ALAlertBanner.h"

#import "BFMShopViewController.h"
#import "BFMShopModel.h"

static NSString *const kBFMCategoryCellID = @"BFMPrizeCategoryCell";
static NSString *const kBFMPrizeBannerCellID = @"BFMPrizeBannerCell";

@interface BFMPrizeCategorisController ()

@property (nonatomic, strong) BFMPrizeCategoriesViewModel *model;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) BFMPrizeCategoriesAdapter *adapter;

@property (weak, nonatomic) IBOutlet UICollectionView *bannerCollectionView;
@property (nonatomic, strong) BFMPrizeBannerAdapter *bannerAdapter;
@property (nonatomic, strong) UIActivityIndicatorView *refreshIndicatorView;

@end

@implementation BFMPrizeCategorisController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self setupIndicatorView];
	
	[self setupCollectionView];
	[self setupModels];
	
	[self setupBannerView];
	[self setupBannerModel];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
	[BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - Private (setup)

- (void)setupIndicatorView {
    self.refreshIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.refreshIndicatorView stopAnimating];
    self.refreshIndicatorView.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.refreshIndicatorView];
}

- (void)setupCollectionView {
	UINib *nib = [UINib nibWithNibName:kBFMCategoryCellID bundle:nil];
	[self.collectionView registerNib:nib
		  forCellWithReuseIdentifier:kBFMCategoryCellID];
}

- (void)setupBannerView {
	UINib *nib = [UINib nibWithNibName:kBFMPrizeBannerCellID bundle:nil];
	[self.bannerCollectionView registerNib:nib
		  forCellWithReuseIdentifier:kBFMPrizeBannerCellID];
}

- (void)setupBannerModel {
	self.bannerAdapter = [[BFMPrizeBannerAdapter alloc] init];
	[self.bannerAdapter mapObjectClass:[BFMBanner class]
					  toCellIdentifier:kBFMPrizeBannerCellID];
	self.bannerAdapter.dataSource = self.model.bannerDataSource;
	self.bannerAdapter.collectionView = self.bannerCollectionView;
	
	
	__weak typeof(self) weakSelf = self;
	[self.model loadBannersWithCallback:^(NSError *error) {
		if (error) {
			ALAlertBanner *banner = [ALAlertBanner alertBannerForView:weakSelf.view.window
																style:ALAlertBannerStyleFailure
															 position:ALAlertBannerPositionUnderNavBar
																title:NSLocalizedString(@"error.error", nil)
															 subtitle:NSLocalizedString(@"error.prizes", nil)];
			[banner show];
		}
	}];
	
	self.bannerAdapter.bannerSelection = ^(BFMBanner *banner) {
		__strong typeof(weakSelf) strongSelf = weakSelf;
		[strongSelf handleBannerSelection:banner];
	};
	
	//if you want to setup selection on screen creation do it here
	self.bannerAdapter.selectedIndex = NSNotFound;
}

- (void)setupModels {
	self.model = [BFMPrizeCategoriesViewModel new];
	
	self.adapter = [[BFMPrizeCategoriesAdapter alloc] init];
	[self.adapter mapObjectClass:[BFMPrizeCategory class]
				toCellIdentifier:kBFMCategoryCellID];
	self.adapter.dataSource = self.model.dataSource;
	self.adapter.collectionView = self.collectionView;
	
	
	__weak typeof(self) weakSelf = self;
    [self.refreshIndicatorView startAnimating];
    self.refreshIndicatorView.hidden = NO;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
	[self.model loadCategoriesWithCallback:^(NSError *error) {
        [SVProgressHUD dismiss];
        [weakSelf.refreshIndicatorView stopAnimating];
        weakSelf.refreshIndicatorView.hidden = YES;
		if (error) {
			ALAlertBanner *banner = [ALAlertBanner alertBannerForView:weakSelf.view.window
																style:ALAlertBannerStyleFailure
															 position:ALAlertBannerPositionUnderNavBar
																title:NSLocalizedString(@"error.error", nil)
															 subtitle:NSLocalizedString(@"error.prizes", nil)];
			[banner show];
		}
	}];
	
	
	self.adapter.selection = ^(NSInteger selectedIndex) {
		__strong typeof(weakSelf) strongSelf = weakSelf;
		
		if (selectedIndex == NSNotFound) {
			//not selected
			
			return;
		}
		
		NSIndexPath *path = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
		BFMPrizeCategory *category = [strongSelf.adapter.dataSource objectAtIndexPath:path];
		
		[strongSelf performSegueWithIdentifier:@"prizeList" sender:category];
	};
	
	//if you want to setup selection on screen creation do it here
	self.adapter.selectedIndex = NSNotFound;
}

- (void)handleBannerSelection:(BFMBanner *)banner {
	[BFMPrize prizeTypeById:banner.prizeId completion:^(BFMPrizeType type, NSError *error) {
		if (error) {
            [self bfm_showError];
			return;
		}
		
		[BFMPrize getPrize:banner.prizeId
				completion:^(BFMPrize *prize, NSError *error) {
                    if (error) {
                        [self bfm_showError];
                    } else if ([prize.prizeType integerValue] == BFMPrizeTypeColor) {
						[self showColoredPrize:prize];
					} else if (type == BFMPrizeTypeText) {
						[self showTextPrize:prize];
					} else if (type == BFMPrizeTypePlain) {
						[self showPlainPrize:prize];
					}
				}];
		
	}];
}

- (void)showColoredPrize:(BFMPrize *)prize {
	UIStoryboard *board = [UIStoryboard storyboardWithName:@"BFMPrize2Lines"
													bundle:nil];
	BFMPrizeLineAndDescriptionViewController *VC = [board instantiateViewControllerWithIdentifier:@"2Lines"];
	VC.selectedPrize = prize;
	[self.navigationController pushViewController:VC animated:YES];
}

- (void)showTextPrize:(BFMPrize *)prize {
	UIStoryboard *board = [UIStoryboard storyboardWithName:@"BFMPrizeLineAndDescription"
													bundle:nil];
	BFMPrizeLineAndDescriptionViewController *VC = [board instantiateViewControllerWithIdentifier:@"2Lines"];
	VC.selectedPrize = prize;
	[self.navigationController pushViewController:VC animated:YES];
}

- (void)showPlainPrize:(BFMPrize *)prize {
	UIStoryboard *board = [UIStoryboard storyboardWithName:@"BFMPrizeLineAndDescription"
													bundle:nil];
	BFMPrizeLineAndDescriptionViewController *VC = [board instantiateViewControllerWithIdentifier:@"2Lines"];
	VC.selectedPrize = prize;
	[self.navigationController pushViewController:VC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"prizeList"]) {
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
		BFMShopModel *model = [[BFMShopModel alloc] initWithCategory:sender];
		BFMShopViewController *controller = [segue destinationViewController];
		controller.model = model;
	}
}

@end
