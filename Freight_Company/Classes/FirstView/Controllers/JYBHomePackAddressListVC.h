//
//  JYBHomePackAddressListVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CPHomeBoxAddressModel.h"


@protocol JYBHomePackAddressListVCDelegate <NSObject>

- (void)selectaddressModel:(CPHomeBoxAddressModel *)addressModel;

@end


@interface JYBHomePackAddressListVC : CCBaseViewController

@property (nonatomic, weak)id <JYBHomePackAddressListVCDelegate>delegate;


@end
