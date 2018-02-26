//
//  JYBHomeModuleCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYBHomeModuleBlock)(NSInteger index);

@interface JYBHomeModuleCell : UITableViewCell

@property (nonatomic ,copy)JYBHomeModuleBlock moudleBlock;

@end
