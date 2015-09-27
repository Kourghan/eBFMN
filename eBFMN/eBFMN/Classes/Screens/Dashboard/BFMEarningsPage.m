//
//  BFMEarningsPage.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 26.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMEarningsPage.h"

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

@end

@implementation BFMEarningsPage

#pragma mark - handlers


- (IBAction)currencyTapped:(id)sender {
    
}

@end
