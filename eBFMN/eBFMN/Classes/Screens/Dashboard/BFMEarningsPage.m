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

@interface BFMEarningsPage ()

@property (weak, nonatomic) IBOutlet UILabel *earningsLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;


@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsValueLabel;

@property (weak, nonatomic) IBOutlet MCPercentageDoughnutView *progressView;

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self bindUser:[BFMUser currentUser]];
    [self reloadData];
}

- (void)reloadData {
    [BFMUser getInfoWithCompletitionBlock:^(BOOL success) {
        [self bindUser:[BFMUser currentUser]];
    }];
}

- (void)bindUser:(BFMUser *)user {
    [self.carousel reloadData];
}

#pragma mark - handlers

- (IBAction)currencyTapped:(id)sender {
    
}

@end
