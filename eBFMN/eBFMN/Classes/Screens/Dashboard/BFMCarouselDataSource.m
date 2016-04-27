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

static NSInteger const kBFMTagType = 1013;
static NSInteger const kBFMTagValue = 1014;

@implementation BFMCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 9;
}

- (UIView *)carousel:(iCarousel *)carousel
  viewForItemAtIndex:(NSInteger)index
         reusingView:(UIView *)reuseView {
    UILabel *value = nil;
    UILabel *type = nil;
    UIImageView *image = nil;
    
    UIView *view;
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        view.backgroundColor = [UIColor whiteColor];
        
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_circle"]];
        CGRect position = CGRectMake((view.frame.size.width / 2) - image.frame.size.width / 2, 0, 107, 107);
        image.frame = position;
        [view addSubview:image];
        
        type = [[UILabel alloc] initWithFrame:CGRectMake(0, 107 + 16, view.frame.size.width, 16.f)];
        type.textAlignment = NSTextAlignmentCenter;
        [type setFont:[UIFont fontWithName:@"ProximaNova-Light" size:12.f]];
        [type setTextColor:[UIColor bfm_lightGrayColor]];
        [view addSubview:type];
        type.tag = kBFMTagType;
        
        value = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, view.frame.size.width, 20.f)];
        value.textAlignment = NSTextAlignmentCenter;
        [value setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:19.f]];
        [value setTextColor:[UIColor bfm_darkBlueColor]];
        value.tag = kBFMTagValue;
        [view addSubview:value];
    } else {
        view = reuseView;
        value = [view viewWithTag:kBFMTagValue];
        type = [view viewWithTag:kBFMTagType];
    }
    
    BFMUser *user = [BFMUser currentUser];
    
    switch (index % 3) {
        case BFMCarouselItemTypeSpread:
            NSLog(@"SPREAD! CURR: %@", user.currentCurrency);
            type.text = NSLocalizedString(@"dashboard.spread", nil);
            value.text = [user spreadForCurrency:self.currentCurrency];
            break;
        case BFMCarouselItemTypeCommission:
            NSLog(@"COMISSION!");
            type.text = NSLocalizedString(@"dashboard.commissions", nil);
            value.text = [user commissionsForCurrency:user.currentCurrency];
            break;
        case BFMCarouselItemTypeRebates:
            NSLog(@"REBATES!");
            type.text = NSLocalizedString(@"dashboard.rebates", nil);
            value.text = [user rebatesForCurrency:self.currentCurrency];
            break;
        default:
            break;
    }

    return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return floorf(carousel.bounds.size.width / 5.95f);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionShowBackfaces: return 0.f;
        case iCarouselOptionFadeMin: return 0.f;
        case iCarouselOptionFadeMax: return 0.f;
        case iCarouselOptionFadeRange: return 1.4f;
        default: return value;
    }
}

@end
