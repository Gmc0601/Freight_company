//
//  JYBHomeImproveItemCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYBHomeImproveBlock)(NSIndexPath *indexPath);

@interface JYBHomeImproveItemCell : UITableViewCell

@property (nonatomic ,copy)JYBHomeImproveBlock improveBlock;

- (void)updateCellWithIcon:(NSString*)icon title:(NSString *)title placeholder:(NSString *)placeholder editIcon:(NSString *)editIcon indexPath:(NSIndexPath *)indexPaht;

@end
