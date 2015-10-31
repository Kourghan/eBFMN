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
#import "BFMPrize.h"

#import "UIColor+Extensions.h"
#import "iCarousel.h"

#import <CZPicker/CZPicker.h>

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BFMEarningsPage () <CZPickerViewDataSource, CZPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *earningsLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;


@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *prizeImageView;

@property (weak, nonatomic) IBOutlet MCPercentageDoughnutView *progressView;

@property (nonatomic, strong) NSArray *currencies;
@property (nonatomic, strong) NSString *selectedCurrency;

@property (nonatomic, strong) CZPickerView *picker;

@property (nonatomic, strong) NSNumber *points;

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
    
    self.progressView.fillColor = [UIColor bfm_defaultNavigationBlue];
    self.progressView.percentage = 0.f;
    self.progressView.linePercentage = 0.08f;
    self.progressView.showTextLabel = NO;
    
    self.carousel.type = iCarouselTypeCylinder;
    self.carousel.pagingEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self bindUser:[BFMUser currentUser]];
    [self reloadData];
    
    self.currencyButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.currencyButton.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.currencyButton.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}

#pragma mark - private methods

- (void)reloadData {
    __weak typeof(self) weakSelf = self;
    [BFMUser getInfoWithCompletitionBlock:^(BOOL success) {
        [weakSelf bindUser:[BFMUser currentUser]];
    }];
    
    [BFMUser getPointsCount:^(NSNumber *points, NSError *error) {
        weakSelf.points = points;
        [BFMPrize currentPrizeWithComplatition:^(BFMPrize * prize, NSError * error) {
            [weakSelf bindPrize:prize];
        }];
    }];
}

- (void)bindUser:(BFMUser *)user {
    self.currencies = [user currencies];
    [self.currencyButton setTitle:[user currentCurrency]
                         forState:UIControlStateNormal];
    self.currencyButton.enabled = ([user numberOfCurrencies] > 1);
    [self.carousel reloadData];
}

- (void)bindPrize:(BFMPrize *)prize {
    [self.pointsValueLabel setText:[NSString stringWithFormat:@"%@/%@",
                                    [self.points stringValue],
                                    [prize.points stringValue]
                                    ]
     ];
    NSURL *url = [NSURL URLWithString:[prize.iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.prizeImageView setImageWithURL:url
                    placeholderImage:[UIImage imageNamed:@"ic_prize1"]];}

- (void)showPicker {
    self.picker = [[CZPickerView alloc] initWithHeaderTitle:NSLocalizedString(@"dashboard.earnings.picker.title", nil)
                                          cancelButtonTitle:NSLocalizedString(@"button.cancel", nil)
                                         confirmButtonTitle:NSLocalizedString(@"button.select", nil)];
    self.picker.headerBackgroundColor = [UIColor bfm_defaultNavigationBlue];
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

- (IBAction)prizesTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(showPrizes)]) {
        [self.delegate showPrizes];
    }
}

- (IBAction)currencyTapped:(id)sender {
    [self showPicker];
}

@end
