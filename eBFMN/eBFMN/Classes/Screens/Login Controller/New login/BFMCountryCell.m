//
//  BFMCountryCell.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/18/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMCountryCell.h"

#import "BFMSignUpCountry.h"

@interface BFMCountryCell ()

@property (nonatomic, weak) IBOutlet UILabel *countryLabel;
@property (nonatomic, weak) IBOutlet UIImageView *flagImageView;
@property (nonatomic, weak) IBOutlet UIImageView *checkmarkImageView;

@end

@implementation BFMCountryCell

- (void)configure:(BFMSignUpCountry *)country selected:(BOOL)selected {
    self.countryLabel.text = country.name;
    
    self.flagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", country.ISOCode.uppercaseString]];
    
    self.checkmarkImageView.image = selected ? [UIImage imageNamed:@"ic_save"] : nil;
}

@end
