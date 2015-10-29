//
//  BFMShopCollectionAdapter.m
//  eBFMN
//
//  Created by Mykyta Shytik on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMShopCollectionAdapter.h"

#import "BFMPrizeCell.h"

// height / width
static CGFloat const kBFMShopCellSideRatio = 21.f / 20.f;
static CGFloat const kBFMShopCellSideRatio6Plus = 24.f / 20.f;

@implementation BFMShopCollectionAdapter

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _selectedIndex = NSNotFound;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BFMPrizeCell *cell = (id)[super collectionView:collectionView
                            cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[BFMPrizeCell class]]) {
        [cell configureSelected:(self.selectedIndex == indexPath.row)];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    self.selectedIndex = (index == self.selectedIndex) ? NSNotFound : index;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat coef = 2.f;
    CGFloat ratio = kBFMShopCellSideRatio;
    if (screenWidth >= 414.f) {
        coef = 3.f;
        ratio = kBFMShopCellSideRatio6Plus;
    }
    
    CGFloat width = floor(screenWidth / coef);
    CGFloat height = floor(width * ratio);
    return CGSizeMake(width, height);
}

@end

