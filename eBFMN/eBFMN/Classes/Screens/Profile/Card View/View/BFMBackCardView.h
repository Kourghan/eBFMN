//
//  BFMBackCardView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFMBackCardDataProvider.h"

@interface BFMBackCardView : UIView

- (void)configureWithDataProvider:(id<BFMBackCardDataProvider>)provider;

@end
