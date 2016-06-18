//
//  BFMCountryCell.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/18/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMSignUpCountry;

@interface BFMCountryCell : UITableViewCell

- (void)configure:(BFMSignUpCountry *)country selected:(BOOL)selected;

@end
