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

#import "JNKeychain+UNTExtension.h"

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
    [self.adapter mapObjectClass:[BFMSysAccount class]
                toCellIdentifier:@"bfmnAccountCell"];
    
    //my.fxcentral.com/login.html?guid=08c410b0-120d-40fa-b650-72e66b19f4ab&goto=/funds/internalTransfer.html?acc=8079 (USD)

    
    [self.adapter setDidSelectObject:^(ODSTableAdapter *sender, BFMSysAccount *object, NSIndexPath *indexPath) {
        [BFMUser getLinkForOffice:^(NSString *link, NSError *error) {
            NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
            NSString *urlString = [NSString stringWithFormat:@"%@/login.html?guid=%@&goto=/funds/internalTransfer.html?acc=%@",
                                   link,
                                   sessionKey,
                                   object.identifier
                                   ];
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
        }];
    }];

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
        NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
        NSString *urlString = [NSString stringWithFormat:@"%@/login.html?guid=%@&goto=/ib/account-list.html?accountType=1",
                               link,
                               sessionKey
                               ];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }];
}

- (IBAction)demoTapped:(id)sender {
    [BFMUser getLinkForOffice:^(NSString *link, NSError *error) {
        NSString *sessionKey = [JNKeychain loadValueForKey:kBFMSessionKey];
        NSString *urlString = [NSString stringWithFormat:@"%@/login.html?guid=%@&goto=/ib/account-list.html?accountType=2",
                               link,
                               sessionKey
                               ];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }];
}

@end
