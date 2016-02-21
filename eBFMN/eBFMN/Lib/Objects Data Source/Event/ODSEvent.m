//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

#import "ODSEvent.h"

#import "ODSSectionChange.h"
#import "ODSObjectChange.h"
#import "ODSBatchObjectChange.h"

@implementation ODSEvent

#pragma mark - Init

- (instancetype)initWithType:(ODSEventType)type {
    self = [super init];
    if (self) {
        _type = type;
    }

    return self;
}

+ (instancetype)eventWithType:(ODSEventType)type {
    NSParameterAssert(type != ODSEventTypeSectionChange);
    NSParameterAssert(type != ODSEventTypeObjectChange);

    return [(ODSEvent *)[self alloc] initWithType:type];
}

- (instancetype)initWithObjectChange:(ODSObjectChange *)change {
    NSParameterAssert(change != nil);
    self = [self initWithType:ODSEventTypeObjectChange];
    if (self) {
        _objectChange = change;
    }

    return self;
}

- (instancetype)initWithBatchObjectChange:(ODSBatchObjectChange *)change {
    NSParameterAssert(change != nil);
    self = [self initWithType:ODSEventTypeBatchObjectChange];
    if (self) {
        _batchObjectChange = change;
    }

    return self;
}

- (instancetype)initWithSectionChange:(ODSSectionChange *)change {
    NSParameterAssert(change != nil);
    self = [self initWithType:ODSEventTypeSectionChange];
    if (self) {
        _sectionChange = change;
    }

    return self;
}

@end