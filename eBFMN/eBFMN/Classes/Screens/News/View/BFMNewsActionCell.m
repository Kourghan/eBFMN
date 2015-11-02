//
//  BFMNewsActionCell.m
//  eBFMN
//
//  Created by Mykyta Shytik on 11/2/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMNewsActionCell.h"

#import "BFMNewsSingleActionCell.h"

@interface BFMNewsActionCell ()<UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation BFMNewsActionCell

#pragma mark - Public

- (void)reloadActions {
    [self.collectionView reloadData];
}

#pragma mark - UIView override

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSString *cellID = NSStringFromClass([BFMNewsSingleActionCell class]);
    UINib *nib = [UINib nibWithNibName:cellID bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellID];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [[self class] actionData].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass([BFMNewsSingleActionCell class]);
    BFMNewsSingleActionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                              forIndexPath:indexPath];
    NSDictionary *cellData = [[self class] actionData][indexPath.row];
    cell.actionTitleLabel.text = cellData[@"name"];
    return cell;
}

#pragma mark - Private

+ (NSArray *)actionData {
    return @[@{@"name": @"Twitter", @"image": @"imagename"},
             @{@"name": @"Facebook", @"image": @"imagename"},
             @{@"name": @"Google +", @"image": @"imagename"},
             @{@"name": @"Message", @"image": @"imagename"}
             ];
}

@end
