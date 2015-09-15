
@import Foundation;

@protocol ODSSection <NSObject>

- (NSString *)name;
- (NSUInteger)numberOfObjects;
- (NSArray *)objects;

@end