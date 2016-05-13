//
//  UIImageView+BFMSetImageRefresh.h
//  eBFMN
//
//  Created by Mykyta Shytik on 5/13/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BFMSetImageRefresh)

- (void)bfm_setImageWithURL:(NSURL *)URL
               refreshAfter:(NSTimeInterval)after
                 completion:(void(^)(void))completion;

@end
