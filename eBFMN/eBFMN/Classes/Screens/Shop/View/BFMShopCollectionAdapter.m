//
//  BFMShopCollectionAdapter.m
//  eBFMN
//
//  Created by Mykyta Shytik on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMShopCollectionAdapter.h"

// height / width
static CGFloat const kBFMShopCellSideRation = 21.f / 20.f;

@implementation BFMShopCollectionAdapter

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat width = floor(screenWidth / 2.f);
    CGFloat height = floor(width * kBFMShopCellSideRation);
    return CGSizeMake(width, height);
}

@end

