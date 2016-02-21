//
// ODSAdapter+Protected.h 
//
// Created by dmitriy on 12/31/13
// Copyright (c) 2013 Yalantis. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ODSAdapter.h"

@interface ODSAdapter (Protected)

/**
* @warning
* Should be implemented
*/
- (id)cellForIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;
- (id)identifierForObjectAtIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(id)cell usingObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (id)configuredCellForObjectAtIndexPath:(NSIndexPath *)indexPath;

/**
* @warning
* Should be implemented
*/
- (id)cellAtIndexPath:(NSIndexPath *)indexPath;

@end