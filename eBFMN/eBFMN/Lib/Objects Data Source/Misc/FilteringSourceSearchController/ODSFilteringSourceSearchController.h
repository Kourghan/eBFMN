
@import Foundation;
@import UIKit;

@protocol ODSFilterable;

@class ODSDataSource;

typedef NSPredicate *(^ODSFilteringSourceSearchControllerPredicateMap)(NSString *input);

FOUNDATION_EXTERN ODSFilteringSourceSearchControllerPredicateMap ODSFilteringSourceSearchControllerDefaultMap(void);

@interface ODSFilteringSourceSearchController : NSObject <UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) ODSDataSource <ODSFilterable> *source;

@property (nonatomic, copy) ODSFilteringSourceSearchControllerPredicateMap predicateMap;

- (void)endSearch;

@end