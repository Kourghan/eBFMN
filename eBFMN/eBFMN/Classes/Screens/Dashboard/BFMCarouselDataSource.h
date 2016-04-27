//
//  BFMCarouselDataSource.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 29.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCarousel.h"

@interface BFMCarouselDataSource : NSObject<iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) NSString *currentCurrency;

@end
