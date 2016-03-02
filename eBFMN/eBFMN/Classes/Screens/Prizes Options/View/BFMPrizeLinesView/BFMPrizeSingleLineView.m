//
//  BFMPrizeSingleLineView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeSingleLineView.h"

#import "BFMPrizeLinesAdapter.h"
#import "BFMLineStubDict.h"

@implementation BFMPrizeSingleLineView

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
    self.topAdapter.objects = [BFMLineStubDict stubs];
    
    [self setupAdaptersContentSizes];
}

- (void)setupAdaptersContentSizes {
    CGSize size = self.bounds.size;
    size.height = size.height * 2;
    self.topAdapter.collectionSize = size;
}

@end
