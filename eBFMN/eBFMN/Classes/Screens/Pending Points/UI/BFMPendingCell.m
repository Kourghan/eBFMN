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
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *enableViews;

@end

@implementation BFMPendingCell

#pragma mark - Public

- (void)configureWithRecord:(BFMPointsRecord *)record {
    self.depositLabel.text = record.deposit.stringValue;
    self.pointsLabel.text = record.points.stringValue;
    self.lotsLabel.text = record.requiredLots.stringValue;
    
    [self configureEnabled:(record.type.integerValue == 0)];
}

#pragma mark - Private

- (void)configureEnabled:(BOOL)enabled {
    for (UIView *view in self.enableViews) {
        view.alpha = enabled ? 1.f : .35f;
    }
}

@end
