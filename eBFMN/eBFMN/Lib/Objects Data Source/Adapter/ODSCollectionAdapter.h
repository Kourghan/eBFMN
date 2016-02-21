//
// Created by zen on 12/12/14.
// Copyright (c) 2014 Smart Checkups. All rights reserved.
//

#import "ODSAdapter.h"

@import UIKit;

@interface ODSCollectionAdapter : ODSAdapter <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

@end