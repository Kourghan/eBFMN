//
//  BFMPrizeLinesView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeLinesView.h"

#import "BFMPrizeLinesAdapter.h"
#import "BFMLineStubDict.h"

@implementation BFMPrizeLinesView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupPrizeViews];
}

- (void)setupPrizeViews {
    self.topAdapter = [BFMPrizeLinesAdapter new];
    self.topAdapter.collectionView = self.topCV;
    
    __weak typeof(self) weakSelf = self;
    self.topAdapter.selection = ^(BFMPrizeLinesAdapter *adapter, NSInteger idx) {
        __strong typeof(weakSelf) sSelf = weakSelf;
        adapter.selectedIndex = idx;
        sSelf.bottomAdapter.selectedIndex = 0;
        
        if (sSelf.selection) {
            sSelf.selection(sSelf,
                            sSelf.topAdapter.selectedIndex,
                            sSelf.bottomAdapter.selectedIndex);
        }
    };
//    self.topAdapter.objects = [BFMLineStubDict stubs];
	
    self.bottomAdapter = [BFMPrizeLinesAdapter new];
    self.bottomAdapter.collectionView = self.bottomCV;
    self.bottomAdapter.selection = ^(BFMPrizeLinesAdapter *adapter, NSInteger idx) {
        __strong typeof(weakSelf) sSelf = weakSelf;
        
        adapter.selectedIndex = idx;
        
        if (sSelf.selection) {
            sSelf.selection(sSelf,
                            sSelf.topAdapter.selectedIndex,
                            sSelf.bottomAdapter.selectedIndex);
        }
    };
    self.bottomAdapter.isOutline = YES;
    
    [self setupAdaptersContentSizes];
}

- (void)setupAdaptersContentSizes {
    self.topAdapter.collectionSize = self.bottomAdapter.collectionSize = self.bounds.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupAdaptersContentSizes];
    [self.topCV.collectionViewLayout invalidateLayout];
    [self.bottomCV.collectionViewLayout invalidateLayout];
}

@end
