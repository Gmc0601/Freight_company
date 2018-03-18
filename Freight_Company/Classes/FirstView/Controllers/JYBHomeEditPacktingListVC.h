//
//  JYBHomeEditPacktingListVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "JYBHomeShipAddressModel.h"

@protocol JYBHomeEditPacktingDelegate <NSObject>

- (void)portPackStationSel:(JYBHomeShipAddressModel *)packStation index:(NSIndexPath *)index;

@end

@interface JYBHomeEditPacktingListVC : CCBaseViewController

@property (nonatomic ,strong)NSString   *shipment_address_id;

@property (nonatomic ,strong)NSIndexPath        *indexPath;

@property (nonatomic ,weak)id <JYBHomeEditPacktingDelegate>delegate;

@end
