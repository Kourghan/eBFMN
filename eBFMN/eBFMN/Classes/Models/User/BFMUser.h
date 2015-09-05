//
//  BFMUser.h
//  
//
//  Created by Mikhail Timoscenko on 05.09.15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BFMUser : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * accCount;
@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * ibsCount;
@property (nonatomic, retain) NSNumber * groupType;
@property (nonatomic, retain) NSNumber * main;

@end
