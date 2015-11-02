//
//  BFMPendingPointsController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPendingPointsController.h"
#import "BFMPendingPointsModel.h"
#import "BFMPointsRecord.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

#import <ALAlertBanner/ALAlertBanner.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "ODSTableAdapter.h"

@interface BFMPendingPointsController ()

@property (nonatomic, strong) BFMPendingPointsModel *model;
@property (nonatomic, strong) ODSTableAdapter *adapter;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation BFMPendingPointsController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupModels];
    
    self.title = self.model.title;
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

#pragma mark - inner methods

- (void)setupModels {
    self.model = [BFMPendingPointsModel new];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    __weak typeof(self) weakSelf = self;
    [self.model loadDataWithCallback:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            ALAlertBanner *banner = [ALAlertBanner alertBannerForView:weakSelf.view.window
                                                                style:ALAlertBannerStyleFailure
                                                             position:ALAlertBannerPositionUnderNavBar
                                                                title:NSLocalizedString(@"error.error", nil)
                                                             subtitle:NSLocalizedString(@"points.badrequest", nil)];
            [banner show];
        }
    }];
    
    self.adapter = [[ODSTableAdapter alloc] init];
    [self.adapter mapObjectClass:[BFMPointsRecord class]
                toCellIdentifier:@"BFMTransactionCell"];
    self.adapter.dataSource = self.model.dataSource;
    self.adapter.tableView = self.tableView;
}

@end
