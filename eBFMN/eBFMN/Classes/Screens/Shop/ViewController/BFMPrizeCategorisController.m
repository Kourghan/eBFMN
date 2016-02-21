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


#import <ALAlertBanner.h>

static NSString *const kBFMCategoryCellID = @"BFMPrizeCategoryCell";

@interface BFMPrizeCategorisController ()

@property (nonatomic, strong) BFMPrizeCategoriesViewModel *model;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) BFMPrizeCategoriesAdapter *adapter;

@property (weak, nonatomic) IBOutlet UICollectionView *bannerCollectionView;
@property (nonatomic, strong) BFMPrizeCategoriesAdapter *bannerAdapter;

@end

@implementation BFMPrizeCategorisController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	[self setupCollectionView];
	[self setupModels];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
	[BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - Private (setup)

- (void)setupCollectionView {
	UINib *nib = [UINib nibWithNibName:kBFMCategoryCellID bundle:nil];
	[self.collectionView registerNib:nib
		  forCellWithReuseIdentifier:kBFMCategoryCellID];
}

- (void)setupModels {
	self.model = [BFMPrizeCategoriesViewModel new];
	
	self.adapter = [[BFMPrizeCategoriesAdapter alloc] init];
	[self.adapter mapObjectClass:[BFMPrizeCategory class]
				toCellIdentifier:kBFMCategoryCellID];
	self.adapter.dataSource = self.model.dataSource;
	self.adapter.collectionView = self.collectionView;
	
	
	__weak typeof(self) weakSelf = self;
	[self.model loadCategoriesWithCallback:^(NSError *error) {
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

	};
	
	//if you want to setup selection on screen creation do it here
	self.adapter.selectedIndex = NSNotFound;
}



@end
