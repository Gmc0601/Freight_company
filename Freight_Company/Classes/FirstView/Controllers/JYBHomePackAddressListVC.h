//
//  JYBHomePackAddressListVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CPHomeBoxAddressModel.h"
#import "JYBHomeShipAddressModel.h"


@protocol JYBHomePackAddressListVCDelegate <NSObject>

@optional

- (void)selectaddressModel:(CPHomeBoxAddressModel *)addressModel;

- (void)selectPointModel:(JYBHomeShipAddressModel *)pointModel indexPaht:(NSIndexPath *)indexPath;

@end


@interface JYBHomePackAddressListVC : CCBaseViewController

@property (nonatomic ,assign)BOOL       isPoint;

@property (nonatomic ,strong)NSIndexPath    *indexPath;

@property (nonatomic ,assign)BOOL       fromBox;

@property (nonatomic, weak)id <JYBHomePackAddressListVCDelegate>delegate;


@end
