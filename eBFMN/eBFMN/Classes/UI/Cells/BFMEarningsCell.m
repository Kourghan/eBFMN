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

@property (nonatomic, weak) IBOutlet UILabel *rebatesValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *rebatesLabel;
@property (nonatomic, weak) IBOutlet UILabel *commissionsValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *commissionsLabel;
@property (nonatomic, weak) IBOutlet UILabel *spreadValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *spreadLabel;


@end

@implementation BFMEarningsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rebatesLabel.text = NSLocalizedString(@"dashboard.rebates", nil);
    self.commissionsLabel.text = NSLocalizedString(@"dashboard.commissions", nil);
    self.spreadLabel.text = NSLocalizedString(@"dashboard.spread", nil);
}

- (void)bind:(BFMUser *)user {
    self.rebatesValueLabel.text = [[user rebates] stringValue];
    self.commissionsValueLabel.text = [[user commissions] stringValue];
    self.spreadValueLabel.text = [[user spread] stringValue];
}

@end
