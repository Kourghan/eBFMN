//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

@import Foundation;

#import "ODSChangeType.h"

@interface ODSObjectChange : NSObject

@property (nonatomic, readonly) ODSChangeType type;
@property (nonatomic, strong) NSIndexPath *targetIndexPath;
@property (nonatomic, strong) NSIndexPath *sourceIndexPath;

- (instancetype)initWithType:(ODSChangeType)type;

@end