//
// ODSAdapter.h
//
// Created by dmitriy on 12/12/13
// Copyright (c) 2013 Yalantis. All rights reserved.
//
#import "ODSEventSubscriber.h"

@class ODSAdapter;

typedef NSString * (^ODSAdapterIdentifierMapper)(ODSAdapter *adapter, id object, NSIndexPath *indexPath);
typedef BOOL (^ODSAdapterMatcher)(ODSAdapter *adapter, id cell, id object, NSIndexPath *indexPath);
typedef void (^ODSAdapterConfiguration)(ODSAdapter *adapter, id cell, id object, NSIndexPath *indexPath);

@interface ODSAdapter : NSObject <ODSEventSubscriber>

@property (nonatomic) BOOL useDefaultConfiguration;

@property (nonatomic, strong) ODSDataSource *dataSource;

#pragma mark - Reload
- (void)setNeedsReload;

- (void)reload;
- (void)reloadAnimated:(BOOL)animated;

- (void)runConfigurationForIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Mapping

- (void)mapObjectClass:(Class)objectClass toCellIdentifierUsing:(ODSAdapterIdentifierMapper)mapper;
- (void)mapObjectClass:(Class)objectClass toCellIdentifier:(NSString *)identifier;
- (void)forCellMatching:(ODSAdapterMatcher)matcher perform:(ODSAdapterConfiguration)configuration;

@end