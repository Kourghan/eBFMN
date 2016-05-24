//
//  BFMLeaderboardViewController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/18/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMLeaderboardViewController.h"
#import "BFMLeaderboardTableViewController.h"
#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"
#import "BFMLeaderboardCell.h"
#import "BFMLeaderboardModel.h"
#import "BFMUser+Extension.h"
#import "UIColor+Extensions.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIViewController+Error.h"

@interface BFMLeaderboardViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *userRecordNumber;
@property (weak, nonatomic) IBOutlet UILabel *userRecordName;
@property (weak, nonatomic) IBOutlet UILabel *userRecordValue;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *dataViewConstr;

@property (nonatomic, strong) NSArray *records;

@end

@implementation BFMLeaderboardViewController

#pragma mark - Lifesycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = NSLocalizedString(@"leaderboard.title", nil);
    [self setupSegmentedControllAppearance];
    [self getLeaderboardRecordsWithType:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
}

- (void)setupSegmentedControllAppearance {
    for (int i=0; i<[self.segmentedControl.subviews count]; i++)
    {
        if ([[self.segmentedControl.subviews objectAtIndex:i] isSelected])
        {
            UIColor *tintcolor = [UIColor bfm_defaultNavigationBlue];
            [[self.segmentedControl.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
        else
        {
            [[self.segmentedControl.subviews objectAtIndex:i] setTintColor:nil];
        }
    }
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [self getLeaderboardRecordsWithType:sender.selectedSegmentIndex];
    [self setupSegmentedControllAppearance];
}

- (void)getLeaderboardRecordsWithType:(NSInteger) type {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    self.dataViewConstr.constant = 0.f;
    __weak typeof(self) weakSelf = self;
    [BFMLeaderboardModel getLeaderboardForType:type+1 success:^(NSArray *records) { //+1 is needed because backend enumeration starts with 1
        [SVProgressHUD dismiss];
        self.records = records;
        [self findUserRecord];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            [weakSelf bfm_showError];
        }
    }];
    
}

- (void)findUserRecord {
    BOOL found = NO;
    for (BFMLeaderboardRecord *record in self.records) {
        if ([record.groupName isEqualToString:[BFMUser currentUser].name]) {
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setPaddingPosition:NSNumberFormatterPadAfterSuffix];
            if (self.segmentedControl.selectedSegmentIndex != 0) {
                [formatter setMaximumFractionDigits:2];
            }
            [formatter setMinimumFractionDigits:0];
            [formatter setDecimalSeparator:@"."];
            
            self.userRecordValue.text = [formatter stringFromNumber:record.value];
            self.userRecordName.text = [NSString stringWithFormat:@"%@ | %@",record.groupName, record.groupID.stringValue];
            self.userRecordNumber.text = @([self.records indexOfObject:record]+1).stringValue;
            found = YES;
        }
    }
    
    self.dataViewConstr.constant = found ? 60.f : 0.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMLeaderboardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaderboardCell"];
    cell.numberLabel.text = @(indexPath.row+1).stringValue;
    BFMLeaderboardRecord *record = [self.records objectAtIndex:indexPath.row];
    [cell configureWithLeaderboardRecord:record andLeaderboardType:self.segmentedControl.selectedSegmentIndex+1];
    return cell;
}

@end
