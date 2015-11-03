//
//  BFMPendingPointsController.m
//  eBFMN
//
//  Created by Mikhail Timoscenko on 01.11.15.
//  Copyright © 2015 eBFMN. All rights reserved.
//

#import "BFMPendingPointsController.h"

#import <MagicalRecord/MagicalRecord.h>
#import "BFMPendingPointsModel.h"
#import "BFMPointsRecord.h"

#import "NINavigationAppearance.h"
#import "BFMDefaultNavagtionBarAppearance.h"

#import <ALAlertBanner/ALAlertBanner.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "BFMPendingTableAdapter.h"
#import "ODSTableAdapter.h"

@interface BFMPendingPointsController ()

@property (nonatomic, strong) BFMPendingPointsModel *model;
@property (nonatomic, strong) ODSTableAdapter *adapter;
@property (nonatomic, strong) BFMPendingTableAdapter *pendingAdapter;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation BFMPendingPointsController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupModels];
    
    self.title = self.model.title;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NINavigationAppearance pushAppearanceForNavigationController:self.navigationController];
    [BFMDefaultNavagtionBarAppearance applyTo:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NINavigationAppearance popAppearanceForNavigationController:self.navigationController];
}

#pragma mark - inner methods

- (void)setupModels {
    self.model = [BFMPendingPointsModel new];
    
    [self stub];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stub2];
    });

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    __weak typeof(self) weakSelf = self;
    [self.model loadDataWithCallback:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            ALAlertBanner *banner = [ALAlertBanner alertBannerForView:weakSelf.view.window
                                                                style:ALAlertBannerStyleFailure
                                                             position:ALAlertBannerPositionUnderNavBar
                                                                title:NSLocalizedString(@"error.error", nil)
                                                             subtitle:NSLocalizedString(@"points.badrequest", nil)];
            [banner show];
        } else {
            [weakSelf.adapter.tableView reloadData];
        }
    }];
    
    self.pendingAdapter = [[BFMPendingTableAdapter alloc] init];
    self.pendingAdapter.tableView = self.tableView;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:245.f / 255.f
                                                green:245.f / 255.f
                                                 blue:245.f / 255.f
                                                alpha:1.f];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)stub {
    [BFMPointsRecord MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    
    NSManagedObjectContext *ctx = [NSManagedObjectContext MR_defaultContext];
    
    {
        NSString *identifier = @"101";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @0;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:87000];
    }
    
    {
        NSString *identifier = @"102";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @1;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:87200];
    }
    
    {
        NSString *identifier = @"103";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @1;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:88000];
    }
    
    {
        NSString *identifier = @"104";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @0;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:87050];
    }
    
    [ctx MR_saveToPersistentStoreAndWait];
}

- (void)stub2 {
    NSManagedObjectContext *ctx = [NSManagedObjectContext MR_defaultContext];
    
    {
        NSString *identifier = @"1101";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @0;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:87000];
    }
    
    {
        NSString *identifier = @"1102";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @1;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:87200];
    }
    
    {
        NSString *identifier = @"1103";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @1;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:88000];
    }
    
    {
        NSString *identifier = @"1104";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
        BFMPointsRecord *rec = [BFMPointsRecord MR_findFirstWithPredicate:predicate inContext:ctx];
        if (!rec) {
            rec = [BFMPointsRecord MR_createEntityInContext:ctx];
        }
        
        rec.identifier = identifier;
        rec.type = @0;
        rec.requiredLots = @240;
        rec.points = @10000;
        rec.deposit = @8000;
        rec.expirationDate = [NSDate dateWithTimeIntervalSinceNow:87050];
    }
    
    [ctx MR_saveToPersistentStoreAndWait];
}

@end
