//
//  BFMPrizeGalleryView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/6/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BFMPrizeGallerySelection)(NSInteger idx);

@interface BFMPrizeGalleryView : UIView

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, weak) NSArray *objects;
@property (nonatomic, copy) BFMPrizeGallerySelection selection;
@property (nonatomic, assign) NSInteger selectedIdx;

+ (instancetype)galleryView;

@end
