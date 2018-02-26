//
//  JYBHomeInproveBoxInfoCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JYBHomeInproveBoxTime,
    JYBHomeInproveBoxNormal,
} JYBHomeInproveBoxType;

@interface JYBHomeInproveBoxInfoCell : UITableViewCell

- (void)updateCellIcon:(NSString *)icon Title:(NSString *)title value:(NSString *)value BoxType:(JYBHomeInproveBoxType)type indexPath:(NSIndexPath *)indexPath;

@end
