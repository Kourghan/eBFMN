//
//  BFMDetailedNewsViewController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMDetailedNewsViewController.h"

#import "BFMNewsRecord.h"
#import "BFMDetailedNewsModel.h"

@interface BFMDetailedNewsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation BFMDetailedNewsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.title;
    
    [self loadDetails];
}

- (void)loadDetails {
	__weak typeof(self) weakSelf = self;
    [self.model fetchDetailedWithCallback:^(BFMNewsRecord *record, NSError *error) {
		if (error) {
			
		} else if (record) {
			weakSelf.titleLabel.text = record.title;
			weakSelf.dateLabel.text = [record formattedDate];
			weakSelf.textLabel.text = record.text;
		}
	}];
}

@end
