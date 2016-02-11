//
//  BFMFrontCardView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/10/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFMFrontCardDataProvider.h"

@interface BFMFrontCardView : UIView

- (void)configureWithDataProvider:(id<BFMFrontCardDataProvider>)provider;

@end
