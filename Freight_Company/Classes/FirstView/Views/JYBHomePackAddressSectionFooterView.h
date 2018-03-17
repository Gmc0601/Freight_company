//
//  JYBHomePackAddressSectionFooterView.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPHomeBoxAddressModel.h"

typedef void(^JYBHomePackDeleBlock)(CPHomeBoxAddressModel *addressModel);

typedef void(^JYBHomePackEditBlock)(CPHomeBoxAddressModel *addressModel);


@interface JYBHomePackAddressSectionFooterView : UITableViewHeaderFooterView

@property (nonatomic ,copy)JYBHomePackDeleBlock deleBlock;

@property (nonatomic ,copy)JYBHomePackDeleBlock editBlock;

@property (nonatomic, strong)CPHomeBoxAddressModel *addressModel;

@end
