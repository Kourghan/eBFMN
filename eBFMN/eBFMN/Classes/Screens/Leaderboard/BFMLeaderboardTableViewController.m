//
//  BFMLeaderboardTableViewController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/17/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMLeaderboardTableViewController.h"


@interface BFMLeaderboardTableView() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BFMLeaderboardTableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.tableHeaderView;
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGRect rect = self.tableHeaderView.frame;
//    rect.origin.y = MIN(0, self.contentOffset.y);
//    self.tableHeaderView.frame = rect;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
