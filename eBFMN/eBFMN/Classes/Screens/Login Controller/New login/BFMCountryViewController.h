//
//  BFMCountryViewController.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/18/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMSignUpCountry;

typedef void (^BFMCountrySelection)(BFMSignUpCountry *country);

@interface BFMCountryViewController : UIViewController

@property (nonatomic, strong) NSString *selectedID;
@property (nonatomic, copy) BFMCountrySelection selection;

@end
