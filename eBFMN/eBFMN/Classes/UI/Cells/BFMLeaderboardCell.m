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
    
    NSArray *stringComponents = [record.value.stringValue componentsSeparatedByString:@"."];
    NSMutableString *integerPartString = [NSMutableString stringWithString:stringComponents[0]];
    
    for (int i = 1; i != [stringComponents[0] length]; i++) {
        if (i%3 == 0) {
          [integerPartString insertString:@"," atIndex:i];
        }
    }
    
    if (stringComponents.count > 1 && leaderBoardType != BFMLeaderboardTypePoints) {
        NSMutableString *fractionString = [NSMutableString stringWithString:stringComponents[1]];
        [fractionString setString:[fractionString substringToIndex:1]];
        self.pointsLabel.text = [[integerPartString stringByAppendingString:@","] stringByAppendingString:fractionString];
    } else {
        self.pointsLabel.text = integerPartString;
    }
    
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
