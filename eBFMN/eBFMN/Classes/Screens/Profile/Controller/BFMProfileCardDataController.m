//
//  BFMProfileCardDataController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 2/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMProfileCardDataController.h"

#import <UIKit/NSAttributedString.h>
#import "BFMUtils.h"

static NSString *const kBFMProfileDataBenefits = @"kBFMProfileDataBenefits";
static NSString *const kBFMProfileDataGoals = @"kBFMProfileDataGoals";
static NSString *const kBFMProfileDataCurrent = @"kBFMProfileDataCurrent";

#define BFM_DEFS [NSUserDefaults standardUserDefaults]

@implementation BFMProfileCardDataController

#pragma mark - NSUserDefaults

+ (NSDictionary *)benefits {
    return [BFM_DEFS objectForKey:kBFMProfileDataBenefits];
}

+ (void)setBenefits:(NSDictionary *)benefits {
    [BFM_DEFS setObject:benefits forKey:kBFMProfileDataBenefits];
    [BFM_DEFS synchronize];
}

+ (NSDictionary *)goals {
    return [BFM_DEFS objectForKey:kBFMProfileDataGoals];
}

+ (void)setGoals:(NSDictionary *)goals {
    [BFM_DEFS setObject:goals forKey:kBFMProfileDataGoals];
    [BFM_DEFS synchronize];
}

+ (BFMLeagueType)currentType {
    return (BFMLeagueType)[BFM_DEFS integerForKey:kBFMProfileDataCurrent];
}

+ (void)setCurrentType:(NSInteger)currentType {
    [BFM_DEFS setInteger:currentType forKey:kBFMProfileDataCurrent];
    [BFM_DEFS synchronize];
}

+ (void)clear {
    NSUserDefaults *defs = BFM_DEFS;
    [defs removeObjectForKey:kBFMProfileDataBenefits];
    [defs removeObjectForKey:kBFMProfileDataGoals];
    [defs removeObjectForKey:kBFMProfileDataCurrent];
    [defs synchronize];
}

#pragma mark - UI

+ (UIImage *)imageForLeagueType:(BFMLeagueType)type back:(BOOL)back {
    switch (type) {
        case BFMLeagueTypeUndefined: return nil;
            
        case BFMLeagueTypeSilver: {
            return [UIImage imageNamed:back ? @"silverback" : @"silver"];
        }
            
        case BFMLeagueTypeGold: {
            return [UIImage imageNamed:back ? @"goldback" : @"gold"];
        }
            
        case BFMLeagueTypePlatinum: {
            return [UIImage imageNamed:back ? @"platinumback" : @"platinum"];
        }
            
        case  BFMLeagueTypeDiamand: {
            return [UIImage imageNamed:back ? @"sapphireback" : @"sapphire"];
        }
            
        default:
            break;
    }
    
    return nil;
}

+ (UIImage *)imageForCurrentType:(BOOL)back {
    return [self imageForLeagueType:[self currentType] back:back];
}

+ (NSString *)backHeaderForLeagueType:(BFMLeagueType)type {
    switch (type) {
        case BFMLeagueTypeUndefined: return @"";
            
        case BFMLeagueTypeSilver: {
            return NSLocalizedString(@"", nil);
        }
            
        case BFMLeagueTypeGold: {
            return NSLocalizedString(@"GOLD BENEFITS", nil);
        }
            
        case BFMLeagueTypePlatinum: {
            return NSLocalizedString(@"PLATINUM BENEFITS", nil);
        }
            
        case  BFMLeagueTypeDiamand: {
            return NSLocalizedString(@"SAPPHIRE BENEFITS", nil);
        }
            
        default:
            break;
    }
    
    return @"";
}

+ (NSString *)backHeaderForCurrentType {
    return [self backHeaderForLeagueType:[self currentType]];
}

+ (NSString *)dictKeyForLeagueType:(BFMLeagueType)type {
    switch (type) {
        case BFMLeagueTypeUndefined: return nil;
            
        case BFMLeagueTypeSilver: {
            return @"Silver";
        }
            
        case BFMLeagueTypeGold: {
            return @"Gold";
        }
            
        case BFMLeagueTypePlatinum: {
            return @"Platinum";
        }
            
        case  BFMLeagueTypeDiamand: {
            return @"Diamond";
        }
            
        default:
            break;
    }
    
    return nil;
}

+ (NSString *)dictKeyForCurrentType {
    return [self dictKeyForLeagueType:[self currentType]];
}

+ (NSAttributedString *)benefitsTextForLeagueType:(BFMLeagueType)type {
    NSString *key = [self dictKeyForLeagueType:type];
    
    if (!key.length) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSDictionary *benefits = [self benefits];
    NSArray *benefitContainer = benefits[key];
    
    if ([benefitContainer isKindOfClass:[NSArray class]]) {
        NSString *text = benefitContainer.firstObject;
        NSString *webString = bfm_webStringFromString(text);
        NSData *data = [webString dataUsingEncoding:NSUnicodeStringEncoding];
        
        
        NSMutableDictionary *options = [NSMutableDictionary new];
        [options setValue:NSHTMLTextDocumentType
                   forKey:NSDocumentTypeDocumentAttribute];
        
        NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithData:data
                                                                                     options:options
                                                                          documentAttributes:nil
                                                                                       error:nil];
        NSRange range = NSMakeRange(0, attText.length);
        [attText addAttribute:NSFontAttributeName
                        value:[self benefitFont]
                        range:range];
        [attText addAttribute:NSForegroundColorAttributeName
                        value:[UIColor whiteColor]
                        range:range];
        
        return attText;
    }
    
    return [[NSAttributedString alloc] initWithString:@""];
}

+ (NSAttributedString *)benefitsTextForCurrentLeague {
    return [self benefitsTextForLeagueType:[self currentType]];
}

+ (NSString *)goalsTextForLeagueType:(BFMLeagueType)type {
    NSString *key = [self dictKeyForLeagueType:type];
    
    if (!key.length) {
        return @"";
    }
    
    NSDictionary *goals = [self goals];
    NSArray *goalCont = goals[key];
    
    if ([goalCont isKindOfClass:[NSArray class]]) {
        NSString *goal = goalCont.firstObject;
        if ([goal isKindOfClass:[NSString class]]) {
            return goal;
        }
    }
    
    return @"";
}

+ (NSString *)goalsTextForCurrentLeague {
    return [self goalsTextForLeagueType:[self currentType]];
}

#pragma mark - Next UI

+ (BFMLeagueType)nextType {
    BFMLeagueType type = [self currentType];
    switch (type) {
        case BFMLeagueTypeSilver: return BFMLeagueTypeGold;
        case BFMLeagueTypeGold: return BFMLeagueTypePlatinum;
        case BFMLeagueTypePlatinum: return BFMLeagueTypeDiamand;
        default: return BFMLeagueTypeUndefined;
    }
}

+ (BOOL)shouldShowNextType {
    return [self nextType] != BFMLeagueTypeUndefined;
}

+ (UIImage *)imageForNextType:(BOOL)back {
    return [self imageForLeagueType:[self nextType] back:back];
}

+ (NSString *)backHeaderForNextType {
    return [self backHeaderForLeagueType:[self nextType]];
}

+ (NSString *)dictKeyForNextType {
    return [self dictKeyForLeagueType:[self nextType]];
}

+ (NSAttributedString *)benefitsTextForNextLeague {
    return [self benefitsTextForLeagueType:[self nextType]];
}

+ (NSString *)goalsTextForNextLeague {
    return [self goalsTextForLeagueType:[self nextType]];
}

#pragma mark -

+ (UIFont *)benefitFont {
    return [UIFont fontWithName:@"ProximaNova-Light" size:15.f];
}

@end
