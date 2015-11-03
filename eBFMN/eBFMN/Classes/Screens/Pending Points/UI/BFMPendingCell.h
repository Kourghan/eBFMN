//
//  BFMPendingCell.h
//  eBFMN
//
//  Created by Mykyta Shytik on 11/2/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMPointsRecord;

@interface BFMPendingCell : UITableViewCell

- (void)configureWithRecord:(BFMPointsRecord *)record;

@end
