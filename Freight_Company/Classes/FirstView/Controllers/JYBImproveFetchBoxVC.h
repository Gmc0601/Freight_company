//
//  JYBImproveFetchBoxVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CPHomeBoxAddressModel.h"

@protocol JYBImproveFetchBoxVCDelegate <NSObject>

- (void)selectBoxAddressModel:(CPHomeBoxAddressModel *)model;

@end


@interface JYBImproveFetchBoxVC : CCBaseViewController

@property (nonatomic ,weak)id <JYBImproveFetchBoxVCDelegate>delegate;

@property (nonatomic ,strong)CPHomeBoxAddressModel *addressModel;

@end
