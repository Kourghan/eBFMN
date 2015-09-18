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

@interface BFMLeaderboardViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *userRecordNumber;
@property (weak, nonatomic) IBOutlet UILabel *userRecordName;
@property (weak, nonatomic) IBOutlet UILabel *userRecordValue;

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
    [BFMLeaderboardModel getLeaderboardForType:sender.selectedSegmentIndex success:^(NSArray *records) {
        self.records = records;
        [self findUserRecord];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        //handle error
    }];
    [self setupSegmentedControllAppearance];
}

- (void)findUserRecord {
    for (BFMLeaderboardRecord *record in self.records) {
        if ([record.groupName isEqualToString:[BFMUser currentUser].name]) {
            self.userRecordValue.text = record.value.stringValue;
            self.userRecordName.text = [NSString stringWithFormat:@"%@ | %@",record.groupName, record.groupID.stringValue];
            self.userRecordNumber.text = @([self.records indexOfObject:record]).stringValue;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMLeaderboardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaderboardCell"];
    cell.numberLabel.text = @(indexPath.row).stringValue;
    BFMLeaderboardRecord *record = [self.records objectAtIndex:indexPath.row];
    [cell configureWithLeaderboardRecord:record];
    return cell;
}

@end
