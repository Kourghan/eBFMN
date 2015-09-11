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

@interface BFMDashboardController ()

@end

@implementation BFMDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[BFMEarningsCell class] forCellReuseIdentifier:@"earnings"];
    [self.tableView registerClass:[BFMClientsCell class] forCellReuseIdentifier:@"clients"];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMBaseDashboardCell *cell = (BFMBaseDashboardCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    [cell bind:[BFMUser stubUser]];
    
    return cell;
}

@end
