//
//  JYBPortSelectCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBHomePortModel.h"

typedef void(^JYBPortSelectBlock)();

typedef void(^JYBPortCommitBlock)();

typedef void(^JYBPortStationBlock)();

typedef void(^JYBExchangeBlock)();

@interface JYBPortSelectCell : UITableViewCell

@property (nonatomic ,copy)JYBPortSelectBlock selectBlock;

@property (nonatomic ,copy)JYBExchangeBlock exchangeBlock;

@property (nonatomic ,copy)JYBPortCommitBlock commitBlock;

@property (nonatomic ,copy)JYBPortStationBlock stationBlock;

- (void)updateCellWithPort:(JYBHomePortModel *)port station:(NSString *)station exchange:(BOOL)exchange;

@end
