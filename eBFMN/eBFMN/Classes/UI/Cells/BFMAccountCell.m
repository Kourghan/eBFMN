//
//  BFMAccountCell.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 30.09.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMAccountCell.h"
#import "BFMSysAccount+Extension.h"

@interface BFMAccountCell ()

@property (weak, nonatomic) IBOutlet UILabel *accountIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;


@end

@implementation BFMAccountCell

- (void)prepareForReuse {
    [super prepareForReuse];
    _object = nil;
}

- (void)setObject:(BFMSysAccount *)object {
    _object = object;
    
    self.accountIdLabel.text = [object.identifier stringValue];
    self.currencyLabel.text = object.currency;
    self.balanceLabel.text = [object balanceString];
}

@end
