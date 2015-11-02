//
//  BFMPendingCell.m
//  eBFMN
//
//  Created by Mykyta Shytik on 11/2/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPendingCell.h"

#import "BFMPointsRecord.h"

@interface BFMPendingCell ()

@property (nonatomic, weak) IBOutlet UIImageView *statusImageView;
@property (nonatomic, weak) IBOutlet UILabel *depositLabel;
@property (nonatomic, weak) IBOutlet UILabel *pointsLabel;
@property (nonatomic, weak) IBOutlet UILabel *lotsLabel;

@end

@implementation BFMPendingCell

- (void)configureWithRecord:(BFMPointsRecord *)record {
    self.depositLabel.text = record.deposit.stringValue;
    self.pointsLabel.text = record.points.stringValue;
    self.lotsLabel.text = record.requiredLots.stringValue;
}

@end
