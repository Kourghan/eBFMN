//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

@import Foundation;

#import "ODSChangeType.h"
#import "JGActionSheet.h"

@protocol ODSSection;

@interface ODSSectionChange : NSObject

@property (nonatomic, readonly) ODSChangeType type;
@property (nonatomic, strong, readonly) NSIndexSet *indexes;

- (instancetype)initWithType:(ODSChangeType)type indexes:(NSIndexSet *)indexes;
- (instancetype)initWithType:(ODSChangeType)type index:(NSUInteger)index;

@end