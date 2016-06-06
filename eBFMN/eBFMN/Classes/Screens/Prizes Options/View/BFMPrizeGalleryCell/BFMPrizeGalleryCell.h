//
//  BFMPrizeGalleryCell.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/6/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMPrizeGalleryCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *galleryImageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *galleryIndicator;

- (void)configure:(NSURL *)URL;

@end
