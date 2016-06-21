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
#import "BFMDetailedNewsViewController.h"
#import "BFMDetailedNewsModel.h"
#import "BFMNewsModel.h"
#import "BFMNewsRecord.h"
#import "BFMNewsCell.h"
#import "ODSDataSource.h"

#import "BFMNewsTableAdapter.h"

#import "UIViewController+Error.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BFMNewsViewController ()<UITableViewDelegate, BFMNewsTableAdapterProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) BFMNewsTableAdapter *adapter;
@property (nonatomic, strong) UIActivityIndicatorView *refreshIndicatorView;

@end

@implementation BFMNewsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.refreshIndicatorView stopAnimating];
    self.refreshIndicatorView.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.refreshIndicatorView];

    self.tableView.estimatedRowHeight = 85.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    
    self.model = [BFMNewsModel new];

    self.title = [self.model.title capitalizedString];
    self.navigationItem.title = [self.model.title uppercaseString];
    
    self.adapter = [BFMNewsTableAdapter new];
    self.adapter.tableView = self.tableView;
    self.adapter.dataSource = self.model.dataSource;
//    self.adapter.tableView.delegate = self;
	self.adapter.delegate = self;
    
    [self.adapter mapObjectClass:[BFMNewsRecord class] toCellIdentifier:@"BFMNewsCell"];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self
                       action:@selector(refreshNews:)
             forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshNews:nil];

    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

- (void)refreshNews:(UIRefreshControl *)control {
    __weak typeof(self) weakSelf = self;
    
    [self.refreshIndicatorView startAnimating];
    self.refreshIndicatorView.hidden = NO;
    
    [self.model loadNewsReset:(control != nil) callback:^(NSError *error) {
        if (control) {
            [control endRefreshing];
        }
        
        [self.refreshIndicatorView stopAnimating];
        self.refreshIndicatorView.hidden = YES;
        if (error) {
            [self bfm_showErrorInOW:NSLocalizedString(@"error.error", nil)
                           subtitle:NSLocalizedString(@"error.connection", nil)];
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(BFMNewsCell *)sender {
    if ([segue.identifier isEqualToString:@"detailedView"]) {
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        BFMDetailedNewsViewController *controller = (BFMDetailedNewsViewController *)segue.destinationViewController;
        BFMDetailedNewsModel *model = [[BFMDetailedNewsModel alloc] initWithRecord:sender.object];
        controller.model = model;
    }
}

- (void)adapterWillDisplayeLastCell:(BFMNewsTableAdapter *)adapter {
	[self refreshNews:nil];
}

@end
