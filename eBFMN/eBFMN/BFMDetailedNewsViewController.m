//
//  BFMDetailedNewsViewController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMDetailedNewsViewController.h"

#import "BFMNewsActionCell.h"
#import "BFMNewsTextCell.h"
#import "BFMNewsRecord.h"

@interface BFMDetailedNewsViewController ()<UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BFMDetailedNewsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    self.textLabel.text = self.record.text;
//    self.titleLabel.text = self.record.title;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd/mm/yyyy"];
//    NSString *stringFromDate = [formatter stringFromDate:self.record.date];
//    self.dateLabel.text = stringFromDate;
//    [self.view layoutSubviews];
//}

#pragma mark - Private (setup)

- (void)setupTableView {
    NSString *identifier = NSStringFromClass([BFMNewsTextCell class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    
    NSString *identifier2 = NSStringFromClass([BFMNewsActionCell class]);
    UINib *nib2 = [UINib nibWithNibName:identifier2 bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:identifier2];
    
    self.tableView.estimatedRowHeight = 85.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)path {
    if (path.row == 0) {
        NSString *cellID = NSStringFromClass([BFMNewsTextCell class]);
        BFMNewsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID
                                                                forIndexPath:path];
        [cell configureWithRecord:self.record];
        return cell;
    }
    
    NSString *cellID = NSStringFromClass([BFMNewsActionCell class]);
    BFMNewsActionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID
                                                              forIndexPath:path];
    [cell reloadActions];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        return UITableViewAutomaticDimension;
    }
    
    return 60.f;
}

@end
