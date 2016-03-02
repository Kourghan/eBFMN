//
//  BFMPrizeLinesView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMPrizeLinesAdapter;

@interface BFMPrizeLinesView : UIView

@property (nonatomic, strong) BFMPrizeLinesAdapter *topAdapter;
@property (nonatomic, strong) BFMPrizeLinesAdapter *bottomAdapter;
@property (nonatomic, weak) IBOutlet UICollectionView *topCV;
@property (nonatomic, weak) IBOutlet UICollectionView *bottomCV;

- (void)setupPrizeViews;
- (void)setupAdaptersContentSizes;

@end
