//
//  BFMPrizeBannerAdapter.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 27.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "ODSCollectionAdapter.h"

typedef void (^BFMShopCollectionSelection)(NSInteger index);

@interface BFMPrizeBannerAdapter : ODSCollectionAdapter

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) BFMShopCollectionSelection selection;

@end
