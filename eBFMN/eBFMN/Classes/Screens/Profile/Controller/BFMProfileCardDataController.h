//
//  BFMProfileCardDataController.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFMUser+Extension.h"
#import <UIKit/UIImage.h>

@interface BFMProfileCardDataController : NSObject

+ (NSDictionary *)benefits;
+ (void)setBenefits:(NSDictionary *)benefits;
+ (NSDictionary *)goals;
+ (void)setGoals:(NSDictionary *)goals;
+ (NSInteger)currentType;
+ (void)setCurrentType:(NSInteger)currentType;
+ (void)clear;

+ (UIImage *)imageForLeagueType:(BFMLeagueType)type back:(BOOL)back;
+ (UIImage *)imageForCurrentType:(BOOL)back;
+ (NSString *)backHeaderForLeagueType:(BFMLeagueType)type;
+ (NSString *)backHeaderForCurrentType;
+ (NSString *)dictKeyForLeagueType:(BFMLeagueType)type;
+ (NSString *)dictKeyForCurrentType;
+ (NSString *)benefitsTextForLeagueType:(BFMLeagueType)type;
+ (NSAttributedString *)benefitsTextForCurrentLeague;
+ (NSString *)goalsTextForLeagueType:(BFMLeagueType)type;
+ (NSString *)goalsTextForCurrentLeague;

@end
