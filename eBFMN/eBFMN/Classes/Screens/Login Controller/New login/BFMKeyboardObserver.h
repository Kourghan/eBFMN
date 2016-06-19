//
//  BFMKeyboardObserver.h
//  eBFMN
//
//  Created by Mykyta Shytik on 6/19/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMKeyboardObserver;

@protocol BFMKeyboardObserverDelegate <NSObject>

@optional
- (void)keyboardObserver:(BFMKeyboardObserver *)observer
   animateKeyboardHeight:(CGFloat)height
                duration:(NSTimeInterval)duration
                   curve:(UIViewAnimationCurve)curve;

@end

@interface BFMKeyboardObserver : NSObject

@property (nonatomic, weak) IBOutlet id<BFMKeyboardObserverDelegate> delegate;
@property (nonatomic, assign, getter = isKbVisible) BOOL kbVisible;

@end
