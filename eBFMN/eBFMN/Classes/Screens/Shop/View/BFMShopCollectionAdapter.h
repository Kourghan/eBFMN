//
//  BFMShopCollectionAdapter.h
//  eBFMN
//
//  Created by Mykyta Shytik on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "ODSCollectionAdapter.h"

typedef void (^BFMShopCollectionSelection)(NSInteger index);

@interface BFMShopCollectionAdapter : ODSCollectionAdapter

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) BFMShopCollectionSelection selection;

@end
