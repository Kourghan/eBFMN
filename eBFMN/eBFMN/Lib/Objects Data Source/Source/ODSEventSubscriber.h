
@import Foundation;

#import "ODSChangeType.h"

@class ODSDataSource, ODSEvent;

@protocol ODSEventSubscriber <NSObject>

- (void)dataSource:(ODSDataSource *)dataSource sentEvent:(ODSEvent *)event;

@end