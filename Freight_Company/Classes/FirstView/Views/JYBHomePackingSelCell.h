//
//  JYBHomePackingSelCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYBHomePackingSelBlock)(NSIndexPath *selIndexPath);

@interface JYBHomePackingSelCell : UITableViewCell

@property (nonatomic ,copy)JYBHomePackingSelBlock selBlock;

- (void)updateCellWithTitle:(NSString *)title result:(NSString *)result indexPath:(NSIndexPath *)indexPath;

@end
