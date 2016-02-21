//
//  BFMTransactionCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 02.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMTransactionCell.h"

@implementation BFMTransactionCell

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)setObject:(BFMPointsRecord *)object {
    _object = object;
    
    
}

@end
