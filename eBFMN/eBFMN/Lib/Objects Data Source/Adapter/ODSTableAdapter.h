//
// ODSTableAdapter.h
//
// Created by dmitriy on 12/12/13
// Copyright (c) 2013 Yalantis. All rights reserved.
//
#import "ODSAdapter.h"

@import UIKit;

@class ODSTableAdapter;

typedef void (^ODSTableAdapterAction)(ODSTableAdapter *sender, id object, NSIndexPath *indexPath);
typedef BOOL (^ODSTableAdapterConfirmation)(ODSTableAdapter *sender, id object, NSIndexPath *indexPath);

@interface ODSTableAdapter : ODSAdapter <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) BOOL immediateSelection; // default to NO

@property (nonatomic) BOOL allowsEditing; // default is NO
@property (nonatomic) BOOL allowSelection; // default is YES

@property (nonatomic, getter=isEditing) BOOL editing;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@property (nonatomic, strong, readonly) id selectedObject;

@property (nonatomic, copy) ODSTableAdapterAction didSelectObject;
@property (nonatomic, copy) ODSTableAdapterConfirmation shouldSelectObject;
- (void)selectObjectAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@property (nonatomic, copy) ODSTableAdapterAction didDeselectObject;
@property (nonatomic, copy) ODSTableAdapterConfirmation shouldDeselectObject;
- (void)deselectObjectAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@property (nonatomic, copy) ODSTableAdapterAction didSelectAccessoryButton;

@property (nonatomic, weak) UITableView *tableView;

@end