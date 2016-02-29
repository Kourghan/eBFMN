//
//  BFMPrizeCategoriesAdapter.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 17.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "ODSCollectionAdapter.h"

typedef void (^BFMShopCollectionSelection)(NSInteger index);

@interface BFMPrizeCategoriesAdapter : ODSCollectionAdapter

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) BFMShopCollectionSelection selection;

@end

