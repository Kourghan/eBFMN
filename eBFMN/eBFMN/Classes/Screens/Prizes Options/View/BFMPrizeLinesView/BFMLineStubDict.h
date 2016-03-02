//
//  BFMLineStubDict.h
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BFMPrizeLinesObject.h"

@interface BFMLineStubDict : NSObject<BFMPrizeLinesObject>

@property (nonatomic, strong) NSString *title;
+ (NSArray *)stubs;
+ (NSArray *)stubs2;

@end
