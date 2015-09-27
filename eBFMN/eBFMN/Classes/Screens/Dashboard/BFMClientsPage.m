//
//  BFMClientsPage.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMClientsPage.h"

#import "BFMUser+Extension.h"

@interface BFMClientsPage ()

@property (weak, nonatomic) IBOutlet UILabel *clientsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalClientsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveClientsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveClientsLabel;

@property (weak, nonatomic) IBOutlet UILabel *demoValueClientsLabel;
@property (weak, nonatomic) IBOutlet UILabel *demoAccountsLabel;

@end

@implementation BFMClientsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clientsLabel.text = NSLocalizedString(@"dashboard.title.clients", nil);
    self.demoAccountsLabel.text = NSLocalizedString(@"dashboard.demoaccounts", nil);
    self.liveClientsLabel.text = NSLocalizedString(@"dashboard.liveaccounts", nil);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self bindUser:[BFMUser currentUser]];
}

- (void)bindUser:(BFMUser *)user {
    self.totalClientsValueLabel.text = [user totalAccountsStringValue];
    self.demoValueClientsLabel.text = [user demoAccountsStringValue];
    self.liveClientsValueLabel.text = [user liveAccountsStringValue];
}

@end
