//
//  BFMNewsTableAdapter.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 14.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsTableAdapter.h"

#import "BFMNewsCell.h"

@interface BFMNewsTableAdapter ()

@property (nonatomic, strong) BFMNewsCell *cell;

@end

@implementation BFMNewsTableAdapter

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger sectionsAmount = [tableView numberOfSections];
	NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
	if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
		if ([self.delegate respondsToSelector:@selector(adapterWillDisplayeLastCell:)]) {
			[self.delegate adapterWillDisplayeLastCell:self];
		}
	}
}

/*
override func tableView(_: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let activity = activities[indexPath.row]
    if activity.type == .LikeComment || activity.type == .Comment {
        cell.setActivity(activities[indexPath.row])
        let size = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return max(size.height, tableView.rowHeight)
    } else {
        return tableView.rowHeight
    }
}
*/
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    BFMNewsCell *cell = (BFMNewsCell *)[tableView cellForRowAtIndexPath:indexPath];
//    CGSize size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return MAX(tableView.rowHeight, size.height);
//}

@end
