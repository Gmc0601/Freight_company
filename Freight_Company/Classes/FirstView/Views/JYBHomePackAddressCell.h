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

@interface JYBHomePackAddressCell : UITableViewCell

- (void)updateCellWithModel:(CPHomeBoxAddressModel *)model;

- (void)updatePointCellWithModel:(JYBHomeShipAddressModel *)model;
@end
