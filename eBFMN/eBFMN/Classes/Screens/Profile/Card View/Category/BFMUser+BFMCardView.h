//
//  BFMUser+BFMCardView.h
//  eBFMN
//
//  Created by Mykyta Shytik on 2/11/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMUser.h"

#import "BFMFrontCardDataProvider.h"
#import "BFMBackCardDataProvider.h"

@interface BFMUser (BFMCardView)
<BFMFrontCardDataProvider, BFMBackCardDataProvider>

@end
