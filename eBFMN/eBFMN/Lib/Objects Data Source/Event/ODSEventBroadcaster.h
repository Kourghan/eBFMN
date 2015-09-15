//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

@import Foundation;

@protocol ODSEventSubscriber;

@class ODSDataSource, ODSEvent;

@interface ODSEventBroadcaster : NSObject

- (instancetype)initWithSender:(ODSDataSource *)sender;

@property (nonatomic, strong, readonly) NSSet *subscribers;
- (void)addSubscriber:(id<ODSEventSubscriber>)subscriber;
- (void)removeSubscriber:(id<ODSEventSubscriber>)subscriber;

- (void)broadcastEvent:(ODSEvent *)event;

- (BOOL)isBroadcastEnabled;
- (void)enableBroadcast;
- (void)disableBroadcast;

@end