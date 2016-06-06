//
//  BFMPrizeLinesAdapter.m
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeLinesAdapter.h"

#import "BFMPrizeLinesCell.h"

@implementation BFMPrizeLinesAdapter

- (void)setCollectionView:(UICollectionView *)collectionView {
    if (collectionView != _collectionView) {
        _collectionView = collectionView;
        NSString *cellID = NSStringFromClass([BFMPrizeLinesCell class]);
        UINib *nib = [UINib nibWithNibName:cellID bundle:nil];
        [self.collectionView registerNib:nib
              forCellWithReuseIdentifier:cellID];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView reloadData];
    }
}

- (void)setObjects:(NSArray *)objects {
    if (_objects != objects) {
        _objects = objects;
        [self.collectionView reloadData];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [self.collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)path {
    NSString *cellID = NSStringFromClass([BFMPrizeLinesCell class]);
    BFMPrizeLinesCell *cell = [cv dequeueReusableCellWithReuseIdentifier:cellID
                                                            forIndexPath:path];
    id<BFMPrizeLinesObject> obj = self.objects[path.row];
    [cell configureWithObject:obj
                     selected:(path.row == self.selectedIndex)
                      outline:self.isOutline
                    isSummary:self.shouldPresentSummary];
    [cell showBottomLine:YES showRightLine:(path.row < self.objects.count - 1)];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selection) {
        self.selection(self, indexPath.row);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat widthDivisor = MIN(4.3f, MAX(1.f, self.objects.count));
    CGSize cvSize = self.collectionSize;
    return CGSizeMake(cvSize.width / (CGFloat)widthDivisor, cvSize.height / 2.f);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    CGFloat frac = scrollView.contentOffset.x / width;
    self.pageControl.currentPage = round(frac);
}

@end
