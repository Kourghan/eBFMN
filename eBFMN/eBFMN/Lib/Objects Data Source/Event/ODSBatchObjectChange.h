//
// Created by zen on 14/04/15.
// Copyright (c) 2015 KustomNote. All rights reserved.
//

@import Foundation;

#import "ODSChangeType.h"

@interface ODSBatchObjectChange : NSObject

@property (nonatomic, readonly) ODSChangeType type;
@property (nonatomic, strong, readonly) NSArray *indexPaths;

- (instancetype)initWithType:(ODSChangeType)type indexPaths:(NSArray *)indexPaths;

@end