//
//  BFMDetailedNewsViewController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMDetailedNewsViewController.h"

#import "BFMNewsRecord.h"
#import "BFMDetailedNewsModel.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

@interface BFMDetailedNewsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BFMDetailedNewsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.title = [NSLocalizedString(@"tabbar.news", nil) uppercaseString];
	
	self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
    [self loadDetails];
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

- (void)loadDetails {
	__weak typeof(self) weakSelf = self;
    [self.model fetchDetailedWithCallback:^(BFMNewsRecord *record, NSError *error) {
		if (error) {
			
		} else if (record) {
			weakSelf.titleLabel.text = record.title;
			weakSelf.dateLabel.text = [record formattedDate];
			weakSelf.textLabel.text = record.text;
		}
	}];
}

@end
