//
//  BFMPrizeCategoriesViewModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.02.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ODSDataSource.h"

@interface BFMPrizeCategoriesViewModel : NSObject

@property (nonatomic, strong) ODSDataSource *dataSource;

- (void)loadCategoriesWithCallback:(void (^)(NSError *error))completion;

@end
