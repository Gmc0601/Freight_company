//
//  JYBHomePackAddressCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPHomeBoxAddressModel.h"
#import "JYBHomeShipAddressModel.h"


typedef void(^JYBHomePackDeleBlock)(id addressModel);

typedef void(^JYBHomePackEditBlock)(id addressModel);

@interface JYBHomePackAddressCell : UITableViewCell


@property (nonatomic ,copy)JYBHomePackDeleBlock deleBlock;

@property (nonatomic ,copy)JYBHomePackDeleBlock editBlock;


- (void)updateCellWithModel:(CPHomeBoxAddressModel *)model;

- (void)updatePointCellWithModel:(JYBHomeShipAddressModel *)model;
@end
