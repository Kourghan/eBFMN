//
//  BFMPrizeGalleryView.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/6/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeGalleryView.h"

#import "BFMPrizeGalleryCell.h"
#import "BFMColoredPrize.h"
#import "BFMPrize.h"

@interface BFMPrizeGalleryView ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@end

@implementation BFMPrizeGalleryView

+ (instancetype)galleryView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self)
                                         owner:nil
                                       options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSString *ID = NSStringFromClass([BFMPrizeGalleryCell class]);
    [self.collectionView registerNib:[UINib nibWithNibName:ID bundle:nil]
          forCellWithReuseIdentifier:ID];
    [self.collectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)setObjects:(NSArray *)objects {
    if (objects != self.objects) {
        _objects = objects;
        [self.collectionView reloadData];
    }
}

- (void)setSelectedIdx:(NSInteger)selectedIdx {
    if (selectedIdx != self.selectedIdx) {
        _selectedIdx = selectedIdx;
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIdx inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = NSStringFromClass([BFMPrizeGalleryCell class]);
    BFMPrizeGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID
                                                                          forIndexPath:indexPath];
    BFMColoredPrize *coloredPrize = self.objects[indexPath.row];
    BFMPrize *prize = coloredPrize.prizes.firstObject;
    [cell configure:[NSURL URLWithString:[prize.iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat w = scrollView.bounds.size.width;
    CGFloat off = scrollView.contentOffset.x;
    
    if (w == 0) return;
    
    CGFloat div = off / w;
    if (self.selection) {
        self.selection(roundf(div));
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

@end
