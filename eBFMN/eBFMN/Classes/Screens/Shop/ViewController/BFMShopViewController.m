//
//  BFMShopViewController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMShopViewController.h"

#import "BFMShopCollectionAdapter.h"
#import "BFMShopModel.h"
#import "BFMPrize.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

#import <MagicalRecord/MagicalRecord.h>
#import <ALAlertBanner/ALAlertBanner.h>

#import "ODSCollectionAdapter.h"
#import "ODSCollectionAdapter.h"

@interface BFMShopViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) BFMShopCollectionAdapter *adapter;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@end

static NSString *const kBFMShopCellID = @"BFMShopConcreteCell";

@implementation BFMShopViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self setupModels];
    
    self.title = self.model.title;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[BFMPrize deleteAllPrizes];
	[self loadData];
    
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
    UINib *nib = [UINib nibWithNibName:kBFMShopCellID bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:kBFMShopCellID];
}

- (void)loadData {
	__weak typeof(self) weakSelf = self;
	
	[self.model loadPrizesWithCallback:^(NSError *error) {
		if (error) {
			ALAlertBanner *banner = [ALAlertBanner alertBannerForView:weakSelf.view.window
																style:ALAlertBannerStyleFailure
															 position:ALAlertBannerPositionUnderNavBar
																title:NSLocalizedString(@"error.error", nil)
															 subtitle:NSLocalizedString(@"error.prizes", nil)];
			[banner show];
		}
	}];
	
	[self.model loadPointsWithCallback:^(NSNumber *points, NSError *error) {
		if (error) {
			ALAlertBanner *banner = [ALAlertBanner alertBannerForView:weakSelf.view.window
																style:ALAlertBannerStyleFailure
															 position:ALAlertBannerPositionUnderNavBar
																title:NSLocalizedString(@"error.error", nil)
															 subtitle:NSLocalizedString(@"error.points", nil)];
			[banner show];
		} else {
			weakSelf.pointsLabel.text = [NSString stringWithFormat:@"%@ %@ %@",
										 NSLocalizedString(@"prizes.youhave", nil),
										 [points stringValue],
										 NSLocalizedString(@"prizes.ibpoints", nil)
										 ];
		}
	}];
}

- (void)setupModels {
    self.adapter = [[BFMShopCollectionAdapter alloc] init];
    [self.adapter mapObjectClass:[BFMPrize class]
                toCellIdentifier:kBFMShopCellID];
    self.adapter.dataSource = self.model.dataSource;
    self.adapter.collectionView = self.collectionView;
	
	__weak typeof(self) weakSelf = self;

    self.adapter.selection = ^(NSInteger selectedIndex) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
		
		if (selectedIndex == NSNotFound) {
			//not selected
			
			return;
		}
		
		
//		
//		if (selectedIndex % 2) {
//			UIStoryboard *board = [UIStoryboard storyboardWithName:@"BFMPrize2Lines"
//															bundle:nil];
//			BFMPrize2LinesViewController *VC = [board instantiateViewControllerWithIdentifier:@"2Lines"];
//			[strongSelf.navigationController pushViewController:VC animated:YES];
//		} else {
//			UIStoryboard *board = [UIStoryboard storyboardWithName:@"BFMPrizeLineAndDescription"
//															bundle:nil];
//			BFMPrize2LinesViewController *VC = [board instantiateViewControllerWithIdentifier:@"2Lines"];
//			[strongSelf.navigationController pushViewController:VC animated:YES];
//		}
		
		NSIndexPath *path = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
		BFMPrize *prize = [strongSelf.adapter.dataSource objectAtIndexPath:path];
		
		switch ([prize.prizeType integerValue]) {
			case BFMPrizeTypeColor:
				[BFMPrize getChildPrizesFrom:prize withCompletion:^(NSArray *prizes, NSError *error) {
					NSLog(@"");
				}];
				break;
			case BFMPrizeTypeText:
				[BFMPrize getChildPrizesFrom:prize withCompletion:^(NSArray *prizes, NSError *error) {
					NSLog(@"");
				}];
				break;
			case BFMPrizeTypePlain:
				[strongSelf showSaveButton:(selectedIndex != NSNotFound)];
				break;
			default:
				[strongSelf showSaveButton:(selectedIndex != NSNotFound)];
				break;
		}
    };
	
    //if you want to setup selection on screen creation do it here
    self.adapter.selectedIndex = NSNotFound;
}

#pragma mark - Private (action)

- (void)saveIfPossible {
    NSInteger index = self.adapter.selectedIndex;
    
    if (index == NSNotFound) {
        //not selected
        
        return;
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    BFMPrize *prize = [self.adapter.dataSource objectAtIndexPath:path];
    
    __weak typeof(self) weakSelf = self;
    [BFMPrize savePrize:prize withCompletition:^(NSError * error) {
        if (error) {
            ALAlertBanner *banner = [ALAlertBanner alertBannerForView:weakSelf.view.window
                                                                style:ALAlertBannerStyleFailure
                                                             position:ALAlertBannerPositionUnderNavBar
                                                                title:NSLocalizedString(@"error.error", nil)
                                                             subtitle:NSLocalizedString(@"error.saving", nil)];
            [banner show];
        } else {
            [weakSelf.navigationController popViewControllerAnimated:TRUE];
        }
    }];
}

- (void)showSaveButton:(BOOL)show {
    if (!show) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        UIBarButtonItemStyle style = UIBarButtonItemStylePlain;
        SEL sel = @selector(saveButtonTap:);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"prizes.save", nil)
                                                                 style:style
                                                                target:self
                                                                action:sel];

        self.navigationItem.rightBarButtonItem = item;
    }
}

#pragma mark - IBAction

- (IBAction)saveButtonTap:(id)sender {
    [self saveIfPossible];
}

@end
