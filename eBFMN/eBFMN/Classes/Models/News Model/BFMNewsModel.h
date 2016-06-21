//
//  BFMNewsModel.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.09.15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ODSDataSource;

@interface BFMNewsModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ODSDataSource *dataSource;
@property (nonatomic, strong) NSFetchedResultsController *frc;

- (void)loadNewsReset:(BOOL)reset callback:(void (^)(NSError *error))callback;;

@end
