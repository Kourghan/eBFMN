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
    self.pointsLabel.text = record.benefit.stringValue;
    self.lotsLabel.text = record.requiredLots.stringValue;
    
    [self configureEnabledForType:[record.type intValue]];
    [self configureIconForType:[record.type intValue]];
}

#pragma mark - Private

- (void)configureEnabledForType:(BFMTransactionType)type {
    for (UIView *view in self.enableViews) {
        view.alpha = (type == BFMTransactionTypeInProgress || type == BFMTransactionTypeNotStared) ? 1.f : .35f;
    }
}

- (void)configureIconForType:(BFMTransactionType)type {
    UIImage *iconImage = [UIImage imageNamed:@"ic_processed"];
    switch (type) {
        case BFMTransactionTypeExpired:
            iconImage = [UIImage imageNamed:@"ic_canceled"];
            break;
        case BFMTransactionTypeCompleted:
            iconImage = [UIImage imageNamed:@"ic_finished"];
            break;
        default:
            break;
    }
    
    [self.imageView setImage:iconImage];
}

@end
