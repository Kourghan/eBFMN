//
//  BFMNewsTextCell.m
//  eBFMN
//
//  Created by Mykyta Shytik on 11/2/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMNewsTextCell.h"

#import "BFMNewsRecord.h"

@interface BFMNewsTextCell ()

@property (nonatomic, weak) IBOutlet UILabel *recordTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *recordTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *recordDateLabel;

@end

@implementation BFMNewsTextCell

#pragma mark - Public

- (void)configureWithRecord:(BFMNewsRecord *)record {
    self.recordTitleLabel.text = record.title;
    self.recordTextLabel.text = record.shortText;
    
    NSDateFormatter *formatter = [[self class] recordDateFormatter];
    self.recordDateLabel.text = [formatter stringFromDate:record.date];
}

#pragma mark - Private

+ (NSDateFormatter *)recordDateFormatter {
    static NSDateFormatter *internalRecordDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        internalRecordDateFormatter = [NSDateFormatter new];
        internalRecordDateFormatter.dateFormat = @"dd/mm/yyyy";
    });
    return internalRecordDateFormatter;
}

@end
