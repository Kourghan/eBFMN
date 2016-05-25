//
//  BFMPrizeBannerAdapter.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "ODSCollectionAdapter.h"

@class BFMBanner;

typedef void (^BFMShopCollectionSelection)(NSInteger index);
typedef void (^BFMBannerSelection)(BFMBanner *banner);

@interface BFMPrizeBannerAdapter : ODSCollectionAdapter

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) BFMShopCollectionSelection selection;
@property (nonatomic, copy) BFMBannerSelection bannerSelection;
@property (nonatomic, copy) BFMShopCollectionSelection swipeToBannerCallback;

@end
