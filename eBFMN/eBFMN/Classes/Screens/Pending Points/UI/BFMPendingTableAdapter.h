//
//  BFMPendingTableAdapter.h
//  eBFMN
//
//  Created by Mykyta Shytik on 11/2/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BFMPendingTableAdapter : NSObject<
UITableViewDataSource,
UITableViewDelegate,
NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end
