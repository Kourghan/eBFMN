//
//  BFMDetailedNewsViewController.h
//  eBFMN
//
//  Created by Ivan Nesterenko on 10/27/15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMNewsRecord;

@interface BFMDetailedNewsViewController : UIViewController

@property (strong, nonatomic) BFMNewsRecord *record;

@end
