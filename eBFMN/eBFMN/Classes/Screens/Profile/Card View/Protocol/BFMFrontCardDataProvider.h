//
//  BFMFrontCardDataProvider.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@protocol BFMFrontCardDataProvider <NSObject>

@required
- (UIImage *)frontCardBackgroundImage;
- (NSString *)frontCardTitleText;
- (NSString *)frontCardExpirationText;
- (NSString *)frontCardCodeText;

@end
