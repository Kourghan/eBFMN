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
    [BFMLeaderboardModel getLeaderboardForType:type+1 success:^(NSArray *records) { //+1 is needed because backend enumeration starts with 1
        [SVProgressHUD dismiss];
        self.records = records;
        [self findUserRecord];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        //handle error
    }];
    
}

- (void)findUserRecord {
    for (BFMLeaderboardRecord *record in self.records) {
        if ([record.groupName isEqualToString:[BFMUser currentUser].name]) {
            
            NSArray *stringComponents = [record.value.stringValue componentsSeparatedByString:@"."];
            NSMutableString *integerPartString = [NSMutableString stringWithString:stringComponents[0]];
            
            for (int i = 1; i != [stringComponents[0] length]; i++) {
                if (i%3 == 0) {
                    [integerPartString insertString:@"," atIndex:i];
                }
            }
            
            if (stringComponents.count > 1 && self.segmentedControl.selectedSegmentIndex != 0) {
                NSMutableString *fractionString = [NSMutableString stringWithString:stringComponents[1]];
                [fractionString setString:[fractionString substringToIndex:1]];
                self.userRecordValue.text = [[integerPartString stringByAppendingString:@","] stringByAppendingString:fractionString];
            } else {
                self.userRecordValue.text = integerPartString;
            }
            
            self.userRecordName.text = [NSString stringWithFormat:@"%@ | %@",record.groupName, record.groupID.stringValue];
            self.userRecordNumber.text = @([self.records indexOfObject:record]+1).stringValue;
        }
    }
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
