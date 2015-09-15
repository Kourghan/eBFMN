#import "ODSSection.h"

@interface ODSArraySection : NSObject <ODSSection, NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger tag;

- (instancetype)initWithObjects:(NSArray *)objects;
+ (instancetype)sectionWithObjects:(NSArray *)objects;

@property (nonatomic, copy) NSArray *objects;
@property (nonatomic, strong, readonly) NSMutableArray *mutableObjects;

@end