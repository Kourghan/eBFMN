//
// Created by zen on 31/07/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

@import Foundation;

#import "ODSDataSource.h"

@class ODSEvent, ODSObjectChange, ODSSectionChange, ODSBatchObjectChange;

@interface ODSDataSource (Protected)

- (void)propagateEvent:(ODSEvent *)event;
- (void)propagateObjectChange:(ODSObjectChange *)objectChange;
- (void)propagateBatchObjectChange:(ODSBatchObjectChange *)change;
- (void)propagateSectionChange:(ODSSectionChange *)sectionChange;

@end