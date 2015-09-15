//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSInteger, ODSEventType) {
    ODSEventTypeReload = 1,
    ODSEventTypeWillBeginUpdate,
    ODSEventTypeDidEndUpdate,
    ODSEventTypeSectionChange,
    ODSEventTypeObjectChange,
    ODSEventTypeBatchObjectChange
};

@class ODSDataSource, ODSObjectChange, ODSBatchObjectChange, ODSSectionChange;

@interface ODSEvent : NSObject

@property (nonatomic, strong, readonly) ODSDataSource *sender;
@property (nonatomic, readonly) ODSEventType type;

/**
* @discussion
* Returns event of specified type.
*
* @warning
* Type can't be ODSEventTypeSectionChange or ODSEventTypeObjectChange.
* Use -initWithObjectChange: and -initWithSectionChange instead.
*
* @returns
* Created event instance with specified type
*/
+ (instancetype)eventWithType:(ODSEventType)type;

@property (nonatomic, strong, readonly) ODSObjectChange *objectChange;
- (instancetype)initWithObjectChange:(ODSObjectChange *)objectChange;

@property (nonatomic, strong, readonly) ODSBatchObjectChange *batchObjectChange;
- (instancetype)initWithBatchObjectChange:(ODSBatchObjectChange *)objectChange;

@property (nonatomic, strong, readonly) ODSSectionChange *sectionChange;
- (instancetype)initWithSectionChange:(ODSSectionChange *)sectionChange;

@end