//
//  BFMUtils.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIFont.h>

extern NSString *bfm_webStringFromString(NSString *rawString);
extern BOOL sbf_isPhone4();
extern BOOL sbf_isPhone5();
extern BOOL sbf_isPhone6();
extern BOOL sbf_isPhone6P();
extern BOOL sbf_matchesSize(CGSize size, CGFloat min, CGFloat max);
extern BOOL sbf_feq(CGFloat f1, CGFloat f2);

extern

@interface BFMUtils : NSObject

@end
