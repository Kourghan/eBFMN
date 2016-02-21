//
//  BFMNewsTextCell.h
//  eBFMN
//
//  Created by Mykyta Shytik on 11/2/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMNewsRecord;

@interface BFMNewsTextCell : UITableViewCell

- (void)configureWithRecord:(BFMNewsRecord *)record;

@end
