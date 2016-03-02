//
//  BFMPrizeLinesObject.h
//  eBFMN
//
//  Created by Mykyta Shytik on 3/1/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;

@protocol BFMPrizeLinesObject <NSObject>

- (UIColor *)bfm_color;
- (BOOL)bfm_isFill; // return YES if fill, NO if stroke
- (NSString *)bfm_title;

@end
