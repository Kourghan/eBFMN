//
//  BFMPrizeCategoriesAdapter.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeCategoriesAdapter.h"
#import "BFMPrizeCategoryCell.h"

// height / width
static CGFloat const kBFMShopCellSideRatio = 175.f / 160.f;
static CGFloat const kBFMShopCellSideRatio6Plus =  175.f / 138.f;

@implementation BFMPrizeCategoriesAdapter

#pragma mark - Init

- (instancetype)init {
	self = [super init];
	if (self) {
		_selectedIndex = NSNotFound;
	}
	return self;
}

#pragma mark - Property

- (void)setSelectedIndex:(NSInteger)selectedIndex {
	_selectedIndex = selectedIndex;
	if (self.selection) {
		self.selection(self.selectedIndex);
	}
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	BFMPrizeCategoryCell *cell = (id)[super collectionView:collectionView
							cellForItemAtIndexPath:indexPath];
	if ([cell isKindOfClass:[BFMPrizeCategoryCell class]]) {
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

