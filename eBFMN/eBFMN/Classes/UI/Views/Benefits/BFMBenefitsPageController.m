//
//  BFMBenefitsPageController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 20.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import "BFMBenefitsPageController.h"

@interface BFMBenefitsPageController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, strong) NSString *titleString;

@end

@implementation BFMBenefitsPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.textView.attributedText = attributedString;
    self.titleLabel.text = self.titleString;
}

- (void)setHTMLString:(NSString *)text title:(NSString *)title{
    _htmlString = text;
    _titleString = title;
}

@end
