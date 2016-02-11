//
//  BFMBackCardDataProvider.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@protocol BFMBackCardDataProvider <NSObject>

@required
- (UIImage *)backCardBackgroundImage;
- (NSString *)backCardTitleText;
- (NSString *)backCardContentText;

@end
