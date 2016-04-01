//
//  BFMPrize+BFMPrizeLines.h
//  eBFMN
//
//  Created by Mykyta Shytik on 3/2/16.
//  Copyright © 2016 eBFMN. All rights reserved.
//

#import "BFMPrize.h"

#import "BFMPrizeLinesObject.h"

@interface BFMPrize (BFMPrizeLines)<BFMPrizeLinesObject>

- (BOOL)bfm_shouldShowSettingsCorner;

@end
