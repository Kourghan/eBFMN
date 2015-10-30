//
//  BFMShopViewController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMShopViewController.h"

#import "BFMShopCollectionAdapter.h"
#import "BFMShopModel.h"
#import "BFMPrize.h"

#import <MagicalRecord/MagicalRecord.h>

#import "ODSCollectionAdapter.h"
#import "ODSCollectionAdapter.h"

@interface BFMShopViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) BFMShopModel *model;
@property (nonatomic, strong) BFMShopCollectionAdapter *adapter;

@end

static NSString *const kBFMShopCellID = @"BFMShopConcreteCell";

@implementation BFMShopViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self setupModels];
}

#pragma mark - Private (setup)

- (void)setupCollectionView {
    UINib *nib = [UINib nibWithNibName:kBFMShopCellID bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:kBFMShopCellID];
}

- (void)setupModels {
    [BFMPrize stubIfNeededInContext:[NSManagedObjectContext MR_defaultContext]];
    
    self.model = [BFMShopModel new];
    
    self.adapter = [[BFMShopCollectionAdapter alloc] init];
    [self.adapter mapObjectClass:[BFMPrize class]
                toCellIdentifier:kBFMShopCellID];
    self.adapter.dataSource = self.model.dataSource;
    self.adapter.collectionView = self.collectionView;
    
    __weak typeof(self) weakSelf = self;
    self.adapter.selection = ^(NSInteger selectedIndex) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showSaveButton:(selectedIndex != NSNotFound)];
    };
    
    //if you want to setup selection on screen creation do it here
    self.adapter.selectedIndex = NSNotFound;
}

#pragma mark - Private (action)

- (void)saveIfPossible {
    NSInteger index = self.adapter.selectedIndex;
    
    if (index == NSNotFound) {
        //not selected
        
        return;
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    BFMPrize *prize = [self.adapter.dataSource objectAtIndexPath:path];
    
    //use prize id or whatever
}

- (void)showSaveButton:(BOOL)show {
    if (!show) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        UIBarButtonItemStyle style = UIBarButtonItemStylePlain;
        SEL sel = @selector(saveButtonTap:);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                 style:style
                                                                target:self
                                                                action:sel];

        self.navigationItem.rightBarButtonItem = item;
    }
}

#pragma mark - IBAction

- (IBAction)saveButtonTap:(id)sender {
    [self saveIfPossible];
}

@end
