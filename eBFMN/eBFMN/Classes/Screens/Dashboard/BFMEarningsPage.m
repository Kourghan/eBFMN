//
//  BFMEarningsPage.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMEarningsPage.h"

#import "BFMUser+Extension.h"

@interface BFMEarningsPage ()

@property (weak, nonatomic) IBOutlet UILabel *reabtesValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *reabatesLabel;

@property (weak, nonatomic) IBOutlet UILabel *commissionValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *commissionLabel;

@property (weak, nonatomic) IBOutlet UILabel *spreadValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *spreadLabel;

@property (weak, nonatomic) IBOutlet UILabel *earningsLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BFMEarningsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.locale = [NSLocale currentLocale];
    
    dateFormatter.dateFormat = @"MMMM";
    NSString * monthString = [[dateFormatter stringFromDate:[NSDate date]] uppercaseString];
    self.monthLabel.text = monthString;
    
    self.earningsLabel.text = NSLocalizedString(@"dashboard.title.earnings", nil);
    self.reabatesLabel.text = NSLocalizedString(@"dashboard.rebates", nil);
    self.commissionLabel.text = NSLocalizedString(@"dashboard.commissions", nil);
    self.spreadLabel.text = NSLocalizedString(@"dashboard.spread", nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self bindUser:[BFMUser currentUser]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat newContentOffsetX = (self.scrollView.contentSize.width - self.scrollView.frame.size.width) / 2;
    self.scrollView.contentOffset = CGPointMake(newContentOffsetX, 0);
}

- (void)bindUser:(BFMUser *)user {
    self.commissionValueLabel.text = [user.commissions stringValue];
    self.spreadValueLabel.text = [[user spread] stringValue];
    self.reabtesValueLabel.text = [[user spread] stringValue];
}

#pragma mark - handlers


- (IBAction)currencyTapped:(id)sender {
    
}

@end
