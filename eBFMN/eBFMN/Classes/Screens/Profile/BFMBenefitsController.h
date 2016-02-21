//
//  BFMBenefitsController.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 20.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BFMProfileInfoTypeBenefits = 0,
    BFMProfileInfoTypeGoals = 1
} BFMProfileInfoType;

@interface BFMBenefitsController : UIViewController

@property (nonatomic) BFMProfileInfoType type;
@property (nonatomic, strong) NSDictionary *data;

@end
