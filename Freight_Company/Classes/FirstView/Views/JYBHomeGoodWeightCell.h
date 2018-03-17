//
//  JYBHomeGoodWeightCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBHomeDockWeightModel.h"

typedef void(^JYBHomeGoodWeightBlock)(JYBHomeDockWeightModel *model);

@interface JYBHomeGoodWeightCell : UITableViewCell

@property (nonatomic ,copy)JYBHomeGoodWeightBlock weightBlock;

- (void)updateCellWithArr:(NSMutableArray *)arr;

@end
