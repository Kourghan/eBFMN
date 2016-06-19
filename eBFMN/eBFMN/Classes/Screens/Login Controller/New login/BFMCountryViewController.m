//
//  BFMCountryViewController.m
//  eBFMN
//
//  Created by Mykyta Shytik on 6/18/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMCountryViewController.h"

#import "BFMDefaultNavagtionBarAppearance.h"
#import "UIViewController+Error.h"
#import "BFMSignInProvider.h"
#import "BFMSignUpCountry.h"
#import "BFMCountryCell.h"

@interface BFMCountryViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) BFMSignInProvider *provider;
@property (nonatomic, strong) NSArray *allCountries;
@property (nonatomic, strong) NSArray *currentCountries;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;

@end

@implementation BFMCountryViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    
    self.searchTextField.spellCheckingType = UITextSpellCheckingTypeNo;
    self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchTextField.delegate = self;
    
    NSString *name = NSStringFromClass([BFMCountryCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil]
         forCellReuseIdentifier:name];
    
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextField.placeholder
                                                                      attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.searchTextField addTarget:self
                             action:@selector(searchTextFieldEditingChanged:)
                   forControlEvents:UIControlEventEditingChanged];
    
    self.provider = [BFMSignInProvider new];
    [self loadData];
}

#pragma mark - Private

- (void)loadData {
    [self.provider getCountries:^(NSArray *countries, NSString *errorString) {
        if (errorString) {
            [self bfm_showErrorInOW:NSLocalizedString(@"error.error", nil)
                           subtitle:errorString];
        } else {
            self.allCountries = countries;
            self.currentCountries = countries;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentCountries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = NSStringFromClass([BFMCountryCell class]);
    BFMCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:name
                                                           forIndexPath:indexPath];
    BFMSignUpCountry *country = self.currentCountries[indexPath.row];
    [cell configure:country
           selected:[country.identifier isEqualToString:self.selectedID]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMSignUpCountry *country = self.currentCountries[indexPath.row];
    self.selectedID = country.identifier;
    [self.tableView reloadData];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return NO;
}

#pragma mark - IBAction

- (IBAction)searchTextFieldEditingChanged:(UITextField *)sender {
    NSString *text = sender.text;
    
    if (!text.length) {
        self.currentCountries = self.allCountries;
    } else {
        NSMutableArray *result = @[].mutableCopy;
        for (BFMSignUpCountry *country in self.allCountries) {
            if ([country.name.lowercaseString containsString:text.lowercaseString]) {
                [result addObject:country];
            }
        }
        self.currentCountries = result.copy;
    }
    
    [self.tableView reloadData];
}

- (IBAction)doneButtonTap:(id)sender {
    if (self.selection && self.selectedID.length) {
        self.selection([self selectdCountry]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BFMSignUpCountry *)selectdCountry {
    for (BFMSignUpCountry *country in self.allCountries) {
        if ([self.selectedID isEqualToString:country.identifier]) {
            return country;
        }
    }
    
    return nil;
}

@end
