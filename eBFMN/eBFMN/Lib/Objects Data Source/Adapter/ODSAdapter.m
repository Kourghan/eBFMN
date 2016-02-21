//
// ODSAdapter.m
//
// Created by dmitriy on 12/12/13
// Copyright (c) 2013 Yalantis. All rights reserved.
//
#import "ODSAdapter.h"
#import "ODSAdapter+Protected.h"

#import "ODSDataSource.h"
#import "NSException+ODSExtension.h"
#import "ODSObjectConsuming.h"

NSString *ODSAdaptedDefaultCellIdentifier(Class objectClass) {
	NSCAssert(objectClass, @"Object class can't be Nil, asshole!");
	return [NSString stringWithFormat:@"%@Cell", NSStringFromClass(objectClass)];
}

@interface ODSAdapter () {
	NSMutableDictionary *_objectClassIdentifierMap;
	NSMapTable *_matcherConfigurationMap;
}

@end

@implementation ODSAdapter

#pragma mark - Init

- (void)dealloc {
	[_dataSource removeSubscriber:self];
}

- (id)init {
	self = [super init];
	if (self) {
		_objectClassIdentifierMap = [NSMutableDictionary new];
		_matcherConfigurationMap = [NSMapTable strongToStrongObjectsMapTable];
		_useDefaultConfiguration = YES;
	}
    
	return self;
}

#pragma mark - Properties

- (void)setDataSource:(ODSDataSource *)dataSource {
	if (_dataSource == dataSource) return;

	[_dataSource removeSubscriber:self];
	_dataSource = dataSource;
	[_dataSource addSubscriber:self];

	[self setNeedsReload];
}

#pragma mark - Reload

- (void)setNeedsReload {
	SEL selector = @selector(reload);
	[self.class cancelPreviousPerformRequestsWithTarget:self selector:selector object:nil];
	[self performSelector:selector withObject:nil afterDelay:0.0 inModes:@[NSRunLoopCommonModes]];
}

- (void)reload {
	[self reloadAnimated:NO];
}

- (void)reloadAnimated:(BOOL)animated {
    [NSException ods_class:self.class selectorImpRequired:_cmd];
}

- (void)runConfigurationForIndexPath:(NSIndexPath *)indexPath {
	id cell = [self cellAtIndexPath:indexPath];
	if (cell) {
		[self configureCell:cell usingObject:self.dataSource[indexPath] atIndexPath:indexPath];
	}
}

#pragma mark - Mapping

- (void)mapObjectClass:(Class)objectClass toCellIdentifierUsing:(ODSAdapterIdentifierMapper)mapper {
	NSParameterAssert(objectClass);
	NSParameterAssert(mapper);

	_objectClassIdentifierMap[(id<NSCopying>)objectClass] = [mapper copy];
}

- (void)mapObjectClass:(Class)objectClass toCellIdentifier:(NSString *)identifier {
    NSString *identifierCopy = [identifier copy];
    [self mapObjectClass:objectClass toCellIdentifierUsing:^NSString *(ODSAdapter *sender, id object, NSIndexPath *indexPath) {
        return identifierCopy;
    }];
}

- (void)forCellMatching:(ODSAdapterMatcher)matcher perform:(ODSAdapterConfiguration)configuration {
	NSParameterAssert(matcher);
	NSParameterAssert(configuration);

	[_matcherConfigurationMap setObject:configuration forKey:matcher];
}

#pragma mark - ODSSourceSubscriber

- (void)dataSource:(ODSDataSource *)dataSource sentEvent:(ODSEvent *)event {
    NSExceptionRaiseInstanceMethodIMPRequired;
}

@end

@implementation ODSAdapter (Protected)

- (id)cellForIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
	[[NSException ods_class:self.class selectorImpRequired:_cmd] raise];

	return nil;
}

- (id)identifierForObjectAtIndexPath:(NSIndexPath *)indexPath {
	id object = [self.dataSource objectAtIndexPath:indexPath];
	ODSAdapterIdentifierMapper identifierMapper = _objectClassIdentifierMap[[object class]];
	if (identifierMapper) {
		return identifierMapper(self, object, indexPath);
	}

#ifdef DEBUG
    NSLog(
        @"<%@> %@: no identifier for object <%@> found. It's strongly not recommended",
        NSStringFromClass(self.class),
        NSStringFromSelector(_cmd),
        NSStringFromClass([object class])
    );
#endif

	return ODSAdaptedDefaultCellIdentifier([object class]);
}

- (void)configureCell:(id)cell usingObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if (self.useDefaultConfiguration && [cell conformsToProtocol:@protocol(ODSObjectConsuming)]) {
        [(id<ODSObjectConsuming>)cell setObject:object];
	}

	for (ODSAdapterMatcher matcher in _matcherConfigurationMap) {
		if (!matcher(self, cell, object, indexPath)) continue;

		ODSAdapterConfiguration configuration = [_matcherConfigurationMap objectForKey:matcher];
		configuration(self, cell, object, indexPath);
	}
}

- (id)configuredCellForObjectAtIndexPath:(NSIndexPath *)indexPath {
	id cell = [self cellForIdentifier:[self identifierForObjectAtIndexPath:indexPath] indexPath:indexPath];
	NSAssert(cell, @"Serious adapter error: no cell for indexPath:%@", indexPath);

	id object = [self.dataSource objectAtIndexPath:indexPath];
	NSAssert(cell, @"Serious adapter error: no object for indexPath:%@", indexPath);

	[self configureCell:cell usingObject:object atIndexPath:indexPath];

	return cell;
}

- (id)cellAtIndexPath:(NSIndexPath *)indexPath {
	[[NSException ods_class:self.class selectorImpRequired:_cmd] raise];

	return nil;
}

@end