//
//  BFMPrizeLinesCell.h
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFMPrizeLinesObject.h"

@interface BFMPrizeLinesCell : UICollectionViewCell

- (void)configureWithObject:(id<BFMPrizeLinesObject>)object
                   selected:(BOOL)selected
                    outline:(BOOL)outline
                  isSummary:(BOOL)isSummary;
- (void)showBottomLine:(BOOL)showBottom showRightLine:(BOOL)showRight;

@end
