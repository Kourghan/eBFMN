//
//  BFMNotificationsController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 18.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNotificationsController.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

#import "BFMNotificationsModel.h"
#import "BFMNotification.h"
#import "BFMNotificationCell.h"

#import "ODSTableAdapter.h"

@interface BFMNotificationsController ()

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ODSTableAdapter *adapter;

@end

@implementation BFMNotificationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 91.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    BFMNotificationsModel *model = [BFMNotificationsModel new];
    self.model = model;
    
    self.navigationItem.title = self.model.title;
    
    self.adapter = [ODSTableAdapter new];
    self.adapter.tableView = self.tableView;
    self.adapter.dataSource = self.model.dataSource;
    
    [self.adapter mapObjectClass:[BFMNotification class] toCellIdentifier:@"BFMNotificationCell"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.investing.com/economic-calendar/"]]];
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

@end
