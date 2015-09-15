//
// Created by zen on 14/04/15.
// Copyright (c) 2015 KustomNote. All rights reserved.
//

#import "ODSBatchObjectChange.h"

@implementation ODSBatchObjectChange

- (instancetype)initWithType:(ODSChangeType)type indexPaths:(NSArray *)indexPaths {
    self = [super init];
    if (self) {
        _type = type;
        _indexPaths = indexPaths;
    }

    return self;
}

@end