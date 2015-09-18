//
//  BFMLeaderboardRecord.h
//  eBFMN
//
//  Created by Ivan Nesterenko on 9/18/15.
//  Copyright (c) 2015 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMLeaderboardRecord : NSObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * groupID;
@property (nonatomic, retain) NSString * groupName;
@property (nonatomic, retain) NSNumber * value;

@end

