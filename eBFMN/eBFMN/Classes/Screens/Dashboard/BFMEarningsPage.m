//
//  BFMEarningsPage.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMEarningsPage.h"

#import "BFMUser+Extension.h"
#import "MCPercentageDoughnutView.h"

#import "UIColor+Extensions.h"
#import "iCarousel.h"

#import <CZPicker/CZPicker.h>

@interface BFMEarningsPage () <CZPickerViewDataSource, CZPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *earningsLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;


@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsValueLabel;

@property (weak, nonatomic) IBOutlet MCPercentageDoughnutView *progressView;

@property (nonatomic, strong) NSArray *currencies;
@property (nonatomic, strong) NSString *selectedCurrency;

@property (nonatomic, strong) CZPickerView *picker;

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
    
    self.progressView.percentage = .33f;
    self.progressView.fillColor = [UIColor bfm_defaultNavigationBlue];
    self.progressView.linePercentage = 0.08f;
    self.progressView.showTextLabel = NO;
    
    self.carousel.type = iCarouselTypeCylinder;
    self.carousel.pagingEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self bindUser:[BFMUser currentUser]];
    [self reloadData];
}

#pragma mark - private methods

- (void)reloadData {
    [BFMUser getInfoWithCompletitionBlock:^(BOOL success) {
        [self bindUser:[BFMUser currentUser]];
    }];
}

- (void)bindUser:(BFMUser *)user {
    self.currencies = [user currencies];

    [self.carousel reloadData];
}

- (void)showPicker {
    self.picker = [[CZPickerView alloc] initWithHeaderTitle:NSLocalizedString(@"earnings.picker.currency", nil)
                                          cancelButtonTitle:NSLocalizedString(@"button.cancel", nil)
                                         confirmButtonTitle:NSLocalizedString(@"button.select", nil)];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    [self.picker show];
}

#pragma mark - UIPickerDelegate

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return (self.currencies == nil) ? 0 : [self.currencies count];
}

- (NSString *)czpickerView:(CZPickerView *)pickerView titleForRow:(NSInteger)row {
    return self.currencies[row];
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    [BFMUser currentUser].currentCurrency = self.currencies[row];
    [self.currencyButton setTitle:[BFMUser currentUser].currentCurrency
                         forState:UIControlStateNormal];
    
    [self.carousel reloadData];
}

#pragma mark - handlers

- (IBAction)currencyTapped:(id)sender {
    [self showPicker];
}

@end
