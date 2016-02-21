//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

#import "ODSSectionChange.h"
#import "ODSArraySection.h"
#import "ODSChangeType.h"
#import "JGActionSheet.h"

@implementation ODSSectionChange

#pragma mark - Init

- (instancetype)initWithType:(ODSChangeType)type indexes:(NSIndexSet *)indexes {
    self = [super init];
    if (self) {
        _type = type;
        _indexes = indexes;
    }

    return self;
}

- (instancetype)initWithType:(ODSChangeType)type index:(NSUInteger)index {
    return [self initWithType:type indexes:[NSIndexSet indexSetWithIndex:index]];
}

@end