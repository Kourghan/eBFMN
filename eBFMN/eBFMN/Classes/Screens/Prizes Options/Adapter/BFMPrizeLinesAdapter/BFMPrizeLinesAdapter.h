//
//  BFMPrizeLinesAdapter.h
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UICollectionViewFlowLayout.h>
#import <UIKit/UICollectionView.h>
#import <CoreGraphics/CGBase.h>

@class BFMPrizeLinesAdapter;

typedef void (^BFMPrizeLinesSelection)(BFMPrizeLinesAdapter *adapter, NSInteger idx);

@interface BFMPrizeLinesAdapter : NSObject<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) BFMPrizeLinesSelection selection;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) CGSize collectionSize;
@property (nonatomic, assign) BOOL isOutline;

@end
