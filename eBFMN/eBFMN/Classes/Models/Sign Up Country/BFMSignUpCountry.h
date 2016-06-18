//
//  BFMSignUpCountry.h
//  
//
//  Created by Mykyta Shytik on 6/18/16.
//
//

#import <Foundation/Foundation.h>

@interface BFMSignUpCountry : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *ISOCode;
@property (nonatomic, strong) NSString *companyID;
@property (nonatomic, strong) NSString *name;

+ (NSArray *)objectsFromResponse:(NSDictionary *)response;

@end
