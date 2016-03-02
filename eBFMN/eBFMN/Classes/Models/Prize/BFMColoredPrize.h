//
//  BFMColoredPrize.h
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.03.16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FastEasyMapping/FastEasyMapping.h>
#import "BFMPrizeLinesObject.h"

@interface BFMColoredPrize : NSObject<BFMPrizeLinesObject>

@property (nonatomic, strong) NSArray *prizes;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *hex;
@property (nonatomic, strong) NSString *link;

@end

@interface BFMColoredPrize (Mapping)

+ (FEMMapping *)defaultMapping;

@end
