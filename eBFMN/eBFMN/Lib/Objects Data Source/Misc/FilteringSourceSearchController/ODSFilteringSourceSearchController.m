#import "ODSFilteringSourceSearchController.h"

#import "ODSDataSource.h"
#import "ODSFilterable.h"

ODSFilteringSourceSearchControllerPredicateMap ODSFilteringSourceSearchControllerDefaultMap(void) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title BEGINSWITH[cd] $VAR"];

    return ^NSPredicate * (NSString *input) {
        NSString *formattedInput = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (formattedInput.length == 0) return nil;

        return [predicate predicateWithSubstitutionVariables:@{@"VAR" : formattedInput}];
    };

};

@implementation ODSFilteringSourceSearchController

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        self.predicateMap = ODSFilteringSourceSearchControllerDefaultMap();
    }

    return self;
}

#pragma mark - Actions

- (void)endSearch {
    [self.searchBar setText:nil];
    [self.searchBar setShowsCancelButton:NO animated:YES];

    [self.source setPredicate:nil];
    [self.source reload];
}

#pragma mark - Search Bar

- (void)setSearchBar:(UISearchBar *)searchBar {
    [_searchBar setDelegate:nil];
    _searchBar = searchBar;
    [_searchBar setDelegate:self];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self endSearch];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];

    [self endSearch];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSPredicate *predicate = self.predicateMap(searchText);
    [self.source setPredicate:predicate];

    [self.source reload];
}

@end