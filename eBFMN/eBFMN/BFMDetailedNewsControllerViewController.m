//
//  BFMDetailedNewsViewController.m
//  eBFMN
//
//  Created by Ivan Nesterenko on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMDetailedNewsViewController.h"

@interface BFMDetailedNewsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation BFMDetailedNewsViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.textLabel.text = self.record.text;
    self.titleLabel.text = self.record.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/mm/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.record.date];
    self.dateLabel.text = stringFromDate;
    [self.view layoutSubviews];
}

@end
