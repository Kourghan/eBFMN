//
//  BFMClientsPage.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMClientsPage.h"

#import "BFMUser+Extension.h"
#import "BFMSysAccount+Extension.h"
#import "BFMAccountCell.h"

#import "ODSTableAdapter.h"
#import "ODSDataSource.h"
#import "ODSArrayDataSource.h"

@interface BFMClientsPage ()

@property (weak, nonatomic) IBOutlet UILabel *clientsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalClientsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveClientsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveClientsLabel;

@property (weak, nonatomic) IBOutlet UILabel *demoValueClientsLabel;
@property (weak, nonatomic) IBOutlet UILabel *demoAccountsLabel;

@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
@property (nonatomic, strong) ODSTableAdapter *adapter;
@property (nonatomic, strong) ODSDataSource *dataSource;

@end

@implementation BFMClientsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clientsLabel.text = NSLocalizedString(@"dashboard.title.clients", nil);
    self.demoAccountsLabel.text = NSLocalizedString(@"dashboard.demoaccounts", nil);
    self.liveClientsLabel.text = NSLocalizedString(@"dashboard.liveaccounts", nil);
    
    self.adapter = [ODSTableAdapter new];
    self.dataSource = [[ODSArrayDataSource alloc] initWithSectionPrototype:nil
                                                                 generator:^NSArray *(ODSArrayDataSource *sender) {
        return [[[BFMUser currentUser] sysAccounts] allObjects];
    }];
    
    self.adapter.tableView = self.accountTableView;
    self.adapter.dataSource = self.dataSource;
    [self.adapter mapObjectClass:[BFMSysAccount class] toCellIdentifier:@"bfmnAccountCell"];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self bindUser:[BFMUser currentUser]];
    [self reloadData];
}

- (void)reloadData {
    [BFMUser getInfoWithCompletitionBlock:^(BOOL success) {
        [self bindUser:[BFMUser currentUser]];
        [self.dataSource reload];
    }];
}

- (void)bindUser:(BFMUser *)user {
    self.totalClientsValueLabel.text = [user totalAccountsStringValue];
    self.demoValueClientsLabel.text = [user demoAccountsStringValue];
    self.liveClientsValueLabel.text = [user liveAccountsStringValue];
}

#pragma mark - handlers

- (IBAction)liveTapped:(id)sender {
    [BFMUser getLinkForOffice:^(NSString *link, NSError *error) {
        NSLog(@"");
    }];
}

- (IBAction)demoTapped:(id)sender {
    [BFMUser getLinkForOffice:^(NSString *link, NSError *error) {
        NSLog(@"");
    }];
}

@end
