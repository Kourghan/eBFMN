//
//  UIImageView+BFMSetImageRefresh.m
//  eBFMN
//
//  Created by Mykyta Shytik on 5/13/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "UIImageView+BFMSetImageRefresh.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (BFMSetImageRefresh)

- (void)bfm_setImageWithURL:(NSURL *)URL
               refreshAfter:(NSTimeInterval)after
                 completion:(void(^)(void))completion {
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:URL
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (!image) {
                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                               [weakSelf bfm_setImageWithURL:URL refreshAfter:after completion:completion];
                           });
                       } else {
                           weakSelf.image = image;
                           if (completion) {
                               completion();
                           }
                       }
                   }];
}

@end
