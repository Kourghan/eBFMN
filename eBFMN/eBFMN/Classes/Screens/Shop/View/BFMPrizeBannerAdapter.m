//
//  BFMPrizeBannerAdapter.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeBannerAdapter.h"
#import "BFMPrizeBannerCell.h"
#import "ODSDataSource.h"

static CGFloat const kBFMPrizeBannerAspectRatio = 2.15f;

@implementation BFMPrizeBannerAdapter

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
	BFMPrizeBannerCell *cell = (id)[super collectionView:collectionView
									cellForItemAtIndexPath:indexPath];
	return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger index = indexPath.row;
	self.selectedIndex = (index == self.selectedIndex) ? NSNotFound : index;
	[self.collectionView reloadData];
    
    BFMBanner *banner = [self.dataSource objectAtIndexPath:indexPath];
    if (banner && self.bannerSelection) {
        self.bannerSelection(banner);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
	return CGSizeMake(screenWidth, screenWidth / kBFMPrizeBannerAspectRatio);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat w = scrollView.frame.size.width;
    CGFloat frac = scrollView.contentOffset.x / w;
    if (self.swipeToBannerCallback) {
        self.swipeToBannerCallback(roundf(frac));
    }
}

@end
