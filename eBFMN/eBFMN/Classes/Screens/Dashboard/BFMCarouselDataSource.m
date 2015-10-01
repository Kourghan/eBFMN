//
//  BFMCarouselDataSource.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 29.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMCarouselDataSource.h"
#import "iCarousel.h"
#import "UIColor+Extensions.h"

#import "BFMUser+Extension.h"

typedef enum {
    BFMCarouselItemTypeSpread = 0,
    BFMCarouselItemTypeCommission = 1,
    BFMCarouselItemTypeRebates = 2
} BFMCarouselItemType;

@implementation BFMCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UILabel *value = nil;
    UILabel *type = nil;
    UIImageView *image = nil;
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_circle"]];
        CGRect position = CGRectMake((view.frame.size.width / 2) - image.frame.size.width / 2, 0, 107, 107);
        image.frame = position;
        [view addSubview:image];
        
        type = [[UILabel alloc] initWithFrame:CGRectMake(0, 107 + 16, view.frame.size.width, 16.f)];
        type.textAlignment = NSTextAlignmentCenter;
        [type setFont:[UIFont fontWithName:@"ProximaNova-Light" size:12.f]];
        [type setTextColor:[UIColor bfm_lightGrayColor]];
        [view addSubview:type];
        
        value = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, view.frame.size.width, 20.f)];
        value.textAlignment = NSTextAlignmentCenter;
        [value setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:19.f]];
        [value setTextColor:[UIColor bfm_darkBlueColor]];
        [view addSubview:value];
    }
    
    BFMUser *user = [BFMUser currentUser];
    
    switch (index) {
        case BFMCarouselItemTypeSpread:
            type.text = NSLocalizedString(@"dashboard.spread", nil);
            value.text = [[user spreadForCurrency:user.currentCurrency] stringValue];
            break;
        case BFMCarouselItemTypeCommission:
            type.text = NSLocalizedString(@"dashboard.commissions", nil);
            value.text = [[user commissionsForCurrency:user.currentCurrency] stringValue];
            break;
        case BFMCarouselItemTypeRebates:
            type.text = NSLocalizedString(@"dashboard.rebates", nil);
            value.text = [[user rebatesForCurrency:user.currentCurrency] stringValue];
            break;
        default:
            break;
    }

    return view;
}

@end
