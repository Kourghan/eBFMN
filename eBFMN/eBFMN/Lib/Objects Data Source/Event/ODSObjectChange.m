//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

#import "ODSObjectChange.h"
#import "ODSSectionChange.h"
#import "ODSEvent.h"
#import "ODSChangeType.h"

@implementation ODSObjectChange

- (instancetype)initWithType:(ODSChangeType)type {
    self = [super init];
    if (self) {
        _type = type;
    }

    return self;
}

@end