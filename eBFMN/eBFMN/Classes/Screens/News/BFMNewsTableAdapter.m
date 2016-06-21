//
//  BFMNewsTableAdapter.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 14.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMNewsTableAdapter.h"

#import "BFMNewsCell.h"
#import "BFMNewsRecord.h"

@interface BFMNewsTableAdapter ()

@property (nonatomic, strong) BFMNewsCell *cell;

@property (nonatomic, strong) BFMNewsCell *protoCell;

@end

@implementation BFMNewsTableAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.protoCell = [[NSBundle mainBundle] loadNibNamed:@"BFMNewsPrototypeCell"
                                                       owner:nil
                                                     options:nil].firstObject;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger sectionsAmount = [tableView numberOfSections];
	NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
	if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
		if ([self.delegate respondsToSelector:@selector(adapterWillDisplayeLastCell:)]) {
			[self.delegate adapterWillDisplayeLastCell:self];
		}
	}
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (!self.providerFRC) {
//        return 1.f;
//    }
//    
//    BFMNewsRecord *record = self.providerFRC.fetchedObjects[indexPath.row];
//    self.protoCell.object = record;
//    self.protoCell.frame = CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, self.protoCell.frame.size.height);
//    [self.protoCell setNeedsLayout];
//    [self.protoCell layoutIfNeeded];
//    CGSize size = [self.protoCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height;
//}

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
