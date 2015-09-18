//
//  BFMDashboardController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMDashboardController.h"

#import "BFMBaseDashboardCell.h"
#import "BFMEarningsCell.h"
#import "BFMClientsCell.h"
#import "BFMUser+Extension.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

@interface BFMDashboardController ()

@end

@implementation BFMDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[BFMEarningsCell class] forCellReuseIdentifier:@"earnings"];
    [self.tableView registerClass:[BFMClientsCell class] forCellReuseIdentifier:@"clients"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    
    self.navigationItem.title = NSLocalizedString(@"dashboard.title", nil);
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    
    [self reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - Network

- (void)reloadData {
    [BFMUser getInfoWithCompletitionBlock:^(BOOL success) {
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMBaseDashboardCell *cell = (BFMBaseDashboardCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    [cell bind:[BFMUser currentUser]];
    
    return cell;
}

@end
