//
//  BFMPrize.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPrize.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation BFMPrize

+ (void)stubInContext:(NSManagedObjectContext *)context {
    if (!context) {
        context = [NSManagedObjectContext MR_defaultContext];
    }
    
    BFMPrize *prize1 = [BFMPrize MR_createEntityInContext:context];
    
    prize1.identifier = @(1);
    prize1.name = @"Apple Watch";

    BFMPrize *prize2 = [BFMPrize MR_createEntityInContext:context];
    
    prize2.identifier = @(2);
    prize2.name = @"Apple MacBook";
    
    BFMPrize *prize3 = [BFMPrize MR_createEntityInContext:context];
    
    prize3.identifier = @(3);
    prize3.name = @"Apple Iphone 6S";
    
    BFMPrize *prize4 = [BFMPrize MR_createEntityInContext:context];
    
    prize4.identifier = @(4);
    prize4.name = @"Case";
    
    BFMPrize *prize5 = [BFMPrize MR_createEntityInContext:context];
    
    prize5.identifier = @(5);
    prize5.name = @"Apple Watch";
    
    [context MR_saveToPersistentStoreAndWait];
}

+ (void)stubIfNeededInContext:(NSManagedObjectContext *)context {
    NSUInteger count = [BFMPrize MR_countOfEntities];
    if (!count) {
        [self stubInContext:context];
    }
}

@end
