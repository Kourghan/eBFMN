//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

#import "ODSDataSource.h"
#import "ODSEventBroadcaster.h"
#import "ODSEventSubscriber.h"
#import "ODSEvent.h"
#import "ODSSectionChange.h"
#import "ODSObjectChange.h"

@interface ODSEventBroadcaster () {
    NSMutableSet *_mutableSubscribers;
	NSInteger _broadcastDisabledCounter;

	__unsafe_unretained ODSDataSource *_dataSource;
}

@end

@implementation ODSEventBroadcaster

#pragma mark - Init

- (instancetype)initWithSender:(ODSDataSource *)sender {
	NSParameterAssert(sender != nil);
	self = [super init];
	if (self) {
		_dataSource = sender;

		_mutableSubscribers = (__bridge_transfer NSMutableSet *)CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
		_broadcastDisabledCounter = 0;
	}

	return self;
}

- (instancetype)init {
	return [self initWithSender:nil];
}

#pragma mark - Subscribers

- (void)addSubscriber:(id<ODSEventSubscriber>)subscriber {
	[_mutableSubscribers addObject:subscriber];
}

- (void)removeSubscriber:(id<ODSEventSubscriber>)subscriber {
	[_mutableSubscribers removeObject:subscriber];
}

- (NSSet *)subscribers {
	return [_mutableSubscribers copy];
}

#pragma mark - Broadcast

- (BOOL)isBroadcastEnabled {
	return _broadcastDisabledCounter <= 0;
}

- (void)enableBroadcast {
	_broadcastDisabledCounter--;
}

- (void)disableBroadcast {
	_broadcastDisabledCounter++;
}

- (void)broadcastEvent:(ODSEvent *)event {
	if (![self isBroadcastEnabled]) {
		return;
	}

	for (id<ODSEventSubscriber> subscriber in self.subscribers) {
        [subscriber dataSource:_dataSource sentEvent:event];
	}
}

@end