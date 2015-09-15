//
// ODSDataSource.m
// Playmaker
//
// Created by dmitriy on 12/12/13
// Copyright (c) 2013 Yalantis. All rights reserved.
//
#import "ODSDataSource.h"
#import "ODSDataSource+Protected.h"

#import "ODSEventSubscriber.h"

#import "NSException+ODSExtension.h"
#import "ODSArraySection.h"
#import "ODSEventBroadcaster.h"
#import "ODSObjectChange.h"
#import "ODSEvent.h"
#import "ODSSectionChange.h"
#import "ODSBatchObjectChange.h"

@interface ODSDataSource () {
    BOOL _reloadNeeded;

    ODSEventBroadcaster *_broadcaster;
}

@end

@implementation ODSDataSource

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        _broadcaster = [[ODSEventBroadcaster alloc] initWithSender:self];
    }

    return self;
}

#pragma mark - Subscription

- (void)addSubscriber:(id<ODSEventSubscriber>)subscriber {
    [_broadcaster addSubscriber:subscriber];
}

- (void)removeSubscriber:(id<ODSEventSubscriber>)subscriber {
    [_broadcaster removeSubscriber:subscriber];
}

#pragma mark - Access

- (NSInteger)numberOfSections {
    NSExceptionRaiseInstanceMethodIMPRequired;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath  {
    NSExceptionRaiseInstanceMethodIMPRequired;
}

- (id<ODSSection>)sectionAtIndex:(NSUInteger)indexPath {
    NSExceptionRaiseInstanceMethodIMPRequired;
}

- (NSIndexPath *)indexPathForObject:(id)object {
    NSExceptionRaiseInstanceMethodIMPRequired;
}

#pragma mark - Update

- (void)setNeedsReload {
	_reloadNeeded = YES;
}

- (void)reloadIfNeeded {
	if (_reloadNeeded) {
        [self reload];
    }
}

- (void)reload {
    _reloadNeeded = NO;

    [self performReload];

    [_broadcaster broadcastEvent:[ODSEvent eventWithType:ODSEventTypeReload]];
}

- (void)performReload {
}

#pragma mark -

- (void)performSuppressingChangesPropagation:(void (^)(void))changes {
    [_broadcaster disableBroadcast];
    changes();
    [_broadcaster enableBroadcast];
}

#pragma mark - Batch Updates

- (void)beginUpdate {
    _updating = YES;
    [_broadcaster broadcastEvent:[ODSEvent eventWithType:ODSEventTypeWillBeginUpdate]];
}

- (void)endUpdate {
    _updating = NO;
    [_broadcaster broadcastEvent:[ODSEvent eventWithType:ODSEventTypeDidEndUpdate]];
}

#pragma mark -

- (NSUInteger)totalObjectsCount {
    NSUInteger count = 0;
    for (id<ODSSection>section in self) {
        count += [section numberOfObjects];
    }

    return count;
}

- (BOOL)isEmpty {
    return self.totalObjectsCount == 0;
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained[])buffer count:(NSUInteger)len {
    NSExceptionRaiseInstanceMethodIMPRequired;
}

@end

@implementation ODSDataSource (Subscription)

- (id<ODSSection>)objectAtIndexedSubscript:(NSUInteger)index {
	return [self sectionAtIndex:index];
}

- (id)objectForKeyedSubscript:(NSIndexPath *)indexPath {
	return [self objectAtIndexPath:indexPath];
}

@end

@implementation ODSDataSource (Protected)

- (void)propagateEvent:(ODSEvent *)event {
    [_broadcaster broadcastEvent:event];
}

- (void)propagateObjectChange:(ODSObjectChange *)objectChange {
    ODSEvent *event = [[ODSEvent alloc] initWithObjectChange:objectChange];
    [_broadcaster broadcastEvent:event];
}

- (void)propagateBatchObjectChange:(ODSBatchObjectChange *)change {
    ODSEvent *event = [[ODSEvent alloc] initWithBatchObjectChange:change];
    [_broadcaster broadcastEvent:event];
}

- (void)propagateSectionChange:(ODSSectionChange *)sectionChange {
    ODSEvent *event = [[ODSEvent alloc] initWithSectionChange:sectionChange];
    [_broadcaster broadcastEvent:event];
}

@end