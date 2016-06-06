//
//  BFMPrizeGalleryCell.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/6/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrizeGalleryCell.h"

#import "UIImageView+BFMSetImageRefresh.h"

@implementation BFMPrizeGalleryCell

- (void)configure:(NSURL *)URL {
    [self.galleryIndicator startAnimating];
    self.galleryIndicator.hidden = NO;
    __weak typeof(self) weakSelf = self;
    [self.galleryImageView bfm_setImageWithURL:URL
                                  refreshAfter:2.0
                                    completion:^{
                                        [weakSelf.galleryIndicator stopAnimating];
                                        weakSelf.galleryIndicator.hidden = YES;
                                    }];
}

@end
