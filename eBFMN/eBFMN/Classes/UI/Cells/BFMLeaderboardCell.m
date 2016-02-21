//
//  BFMLeaderboardCell.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/18/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMLeaderboardCell.h"
#import "BFMUser+Extension.h"
#import "UIColor+Extensions.h"

@interface BFMLeaderboardCell()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *pointsLabel;

@end

@implementation BFMLeaderboardCell

- (void)configureWithLeaderboardRecord:(BFMLeaderboardRecord *)record andLeaderboardType:(BFMLeaderboardType)leaderBoardType{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ | %@",record.groupName, record.groupID.stringValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setPaddingPosition:NSNumberFormatterPadAfterSuffix];
    if (leaderBoardType != BFMLeaderboardTypePoints) {
        [formatter setMaximumFractionDigits:2];
    }
    [formatter setMinimumFractionDigits:0];
    [formatter setDecimalSeparator:@"."];
    
    self.pointsLabel.text = [formatter stringFromNumber:record.value];
    if ([record.groupName isEqualToString:[BFMUser currentUser].name]) {
        self.backgroundColor = [UIColor bfm_defaultNavigationBlue];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.pointsLabel.textColor = [UIColor whiteColor];
        self.numberLabel.textColor = [UIColor whiteColor];
    }
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.backgroundColor = [UIColor clearColor];
    self.nameLabel.textColor = [UIColor blackColor];
    self.pointsLabel.textColor = [UIColor blackColor];
    self.numberLabel.textColor = [UIColor blackColor];
}

@end
