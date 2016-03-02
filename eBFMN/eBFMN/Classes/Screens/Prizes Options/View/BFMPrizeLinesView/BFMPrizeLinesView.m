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

@interface BFMPrizeLinesView ()

@property (nonatomic, weak) IBOutlet UICollectionView *topCV;
@property (nonatomic, weak) IBOutlet UICollectionView *bottomCV;

@end

@implementation BFMPrizeLinesView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.topAdapter = [BFMPrizeLinesAdapter new];
    self.topAdapter.collectionView = self.topCV;
    
    __weak typeof(self) weakSelf = self;
    self.topAdapter.selection = ^(BFMPrizeLinesAdapter *adapter, NSInteger idx) {
        __strong typeof(weakSelf) sSelf = weakSelf;
        adapter.selectedIndex = idx;
        sSelf.bottomAdapter.selectedIndex = 0;
    };
    self.topAdapter.objects = [BFMLineStubDict stubs];
    
    self.bottomAdapter = [BFMPrizeLinesAdapter new];
    self.bottomAdapter.collectionView = self.bottomCV;
    self.bottomAdapter.selection = ^(BFMPrizeLinesAdapter *adapter, NSInteger idx) {
        adapter.selectedIndex = idx;
    };
    self.bottomAdapter.isOutline = YES;
    self.bottomAdapter.objects = [BFMLineStubDict stubs2];
    
    self.topAdapter.collectionSize = self.bottomAdapter.collectionSize = self.bounds.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topAdapter.collectionSize = self.bottomAdapter.collectionSize = self.bounds.size;
    [self.topCV.collectionViewLayout invalidateLayout];
    [self.bottomCV.collectionViewLayout invalidateLayout];
}

@end
