//
//  BFMNewsViewController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsViewController.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

#import "BFMNewsModel.h"
#import "BFMNewsRecord.h"
#import "BFMNewsCell.h"

#import "BFMNewsTableAdapter.h"

@interface BFMNewsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) BFMNewsTableAdapter *adapter;

@end

@implementation BFMNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 85.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    BFMNewsModel *model = [BFMNewsModel new];
    self.model = model;
    
    self.navigationItem.title = self.model.title;
    
    self.adapter = [BFMNewsTableAdapter new];
    self.adapter.tableView = self.tableView;
    self.adapter.dataSource = self.model.dataSource;
    
    [self.adapter mapObjectClass:[BFMNewsRecord class] toCellIdentifier:@"BFMNewsCell"];
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
