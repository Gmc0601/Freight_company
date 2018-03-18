//
//  JYBHomeImproBoxSaveCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYBHomeImproBoxSaveBlock)();

@interface JYBHomeImproBoxSaveCell : UITableViewCell

@property (nonatomic ,copy)JYBHomeImproBoxSaveBlock saveBlock;

@property (nonatomic ,strong)UIButton   *seleBtn;

@end
