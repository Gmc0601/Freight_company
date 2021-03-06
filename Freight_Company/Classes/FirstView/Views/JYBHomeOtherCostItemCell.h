//
//  JYBHomeOtherCostItemCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBHomeDockWeightModel.h"
#import "JYBHomeDotModel.h"

@interface JYBHomeOtherCostItemCell : UICollectionViewCell

- (void)updateCellWithModel:(JYBHomeDockWeightModel *)model;

- (void)updateDotCellWithModel:(JYBHomeDotModel *)model;

@end
