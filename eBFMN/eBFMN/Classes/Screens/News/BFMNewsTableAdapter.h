//
//  BFMNewsTableAdapter.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 14.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "ODSTableAdapter.h"

@protocol BFMNewsTableAdapterProtocol;

@interface BFMNewsTableAdapter : ODSTableAdapter

@property (nonatomic, weak) id<BFMNewsTableAdapterProtocol> delegate;

@end

@protocol BFMNewsTableAdapterProtocol <NSObject>

- (void)adapterWillDisplayeLastCell:(BFMNewsTableAdapter *)adapter;

@end
