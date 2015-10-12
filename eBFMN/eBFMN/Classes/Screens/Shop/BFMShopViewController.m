//
//  BFMShopViewController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 11.10.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMShopViewController.h"
#import "BFMShopModel.h"
#import "BFMPrize.h"

#import <MagicalRecord/MagicalRecord.h>

#import "ODSCollectionAdapter.h"
#import "ODSCollectionAdapter.h"

@interface BFMShopViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) BFMShopModel *model;
@property (nonatomic, strong) ODSCollectionAdapter *adapter;

@end

@implementation BFMShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BFMPrize stubInContext:[NSManagedObjectContext MR_defaultContext]];
    
    self.adapter = [[ODSCollectionAdapter alloc] init];
    
    [self.adapter mapObjectClass:[BFMPrize class] toCellIdentifier:@"prizeCell"];
    
    self.model = [BFMShopModel new];
    self.adapter.dataSource = self.model.dataSource;
    self.adapter.collectionView = self.collectionView;
}

@end
