//
//  BFMEarningsCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMEarningsCell.h"

#import "BFMUser+Extension.h"

@interface BFMEarningsCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *rebatesValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *rebatesLabel;
@property (nonatomic, weak) IBOutlet UILabel *commissionsValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *commissionsLabel;
@property (nonatomic, weak) IBOutlet UILabel *spreadValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *spreadLabel;
@property (nonatomic, weak) IBOutlet UILabel *monthLabel;

@end

@implementation BFMEarningsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.locale = [NSLocale currentLocale];
    
    dateFormatter.dateFormat = @"MMMM";
    NSString * monthString = [[dateFormatter stringFromDate:[NSDate date]] uppercaseString];
    self.monthLabel.text = monthString;
    
    self.titleLabel.text = NSLocalizedString(@"dashboard.title.earnings", nil);
    self.rebatesLabel.text = NSLocalizedString(@"dashboard.rebates", nil);
    self.commissionsLabel.text = NSLocalizedString(@"dashboard.commissions", nil);
    self.spreadLabel.text = NSLocalizedString(@"dashboard.spread", nil);
}

- (void)bind:(BFMUser *)user {
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Bold" size:15.f]};
    const NSRange range = NSMakeRange(0,1);
    
    NSMutableAttributedString *rebatesAttributedText =
    [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%@", [[user rebates] stringValue]]
                                           attributes:nil];
    [rebatesAttributedText setAttributes:attrs range:range];
    [self.rebatesValueLabel setAttributedText:rebatesAttributedText];
    
    NSMutableAttributedString *commissionsAttributedText =
    [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%@", [[user commissions] stringValue]]
                                           attributes:nil];
    [commissionsAttributedText setAttributes:attrs range:range];
    [self.commissionsValueLabel setAttributedText:commissionsAttributedText];
    
    NSMutableAttributedString *spreadAttributedText =
    [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%@", [[user spread] stringValue]]
                                           attributes:nil];
    [spreadAttributedText setAttributes:attrs range:range];
    [self.spreadValueLabel setAttributedText:spreadAttributedText];
}

@end
