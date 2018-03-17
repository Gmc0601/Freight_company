//
//  JYBHomePortCostCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JYBHomeDotModel.h"

typedef void(^JYBHomePortBlock)(JYBHomeDotModel *model);

@interface JYBHomePortCostCell : UITableViewCell

@property (nonatomic ,copy)JYBHomePortBlock portBlock;

- (void)updateCellWithArr:(NSMutableArray *)arr;

@end
