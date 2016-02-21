//
//  ODSChangeType.h
//  Smart Checkups
//
//  Created by zen on 12/12/14.
//  Copyright (c) 2014 Smart Checkups. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSInteger, ODSChangeType) {
    ODSChangeTypeInsert = 1,
    ODSChangeTypeDelete = 2,
    ODSChangeTypeMove = 3,
    ODSChangeTypeUpdate = 4,
};