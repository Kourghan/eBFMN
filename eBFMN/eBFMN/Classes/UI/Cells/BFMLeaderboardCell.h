//
//  BFMLeaderboardCell.h
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/18/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMLeaderboardRecord.h"

@interface BFMLeaderboardCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *numberLabel;

- (void)configureWithLeaderboardRecord:(BFMLeaderboardRecord *)record;

@end
