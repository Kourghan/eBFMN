
#import "ODSDataSource.h"

@protocol ODSFilterable <NSObject>

@required
@property (nonatomic, strong) NSPredicate *predicate;
@property (nonatomic) BOOL awaitsPredicate;

@end