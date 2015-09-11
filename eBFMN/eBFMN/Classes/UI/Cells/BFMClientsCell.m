//
//  BFMClientsCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMClientsCell.h"

#import "BFMUser+Extension.h"

@interface BFMClientsCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *freshAccountsLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalAccountsCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *demoAccountCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *liveAccountCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *demoAccountLabel;
@property (nonatomic, weak) IBOutlet UILabel *liveAccountLabel;

@end

@implementation BFMClientsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.text = NSLocalizedString(@"dashboard.title.clients", nil);
    self.demoAccountLabel.text = NSLocalizedString(@"dashboard.demoaccounts", nil);
    self.liveAccountLabel.text = NSLocalizedString(@"dashboard.liveaccounts", nil);
}

- (void)bind:(BFMUser *)user {
    self.totalAccountsCountLabel.text = [user totalAccountsStringValue];
    self.demoAccountCountLabel.text = [user demoAccountsStringValue];
    self.liveAccountCountLabel.text = [user liveAccountsStringValue];
    self.freshAccountsLabel.text = [user freshAccountsStringValue];
}

@end
