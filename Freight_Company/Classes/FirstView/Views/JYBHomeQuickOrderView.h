//
//  JYBHomeQuickOrderView.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBHomeQuickModel.h"

/**
 LGCustomAlertView 回调
 
 @param index --> 0：取消  1：确认  OtherItems 从2开始依次推
 */
typedef void(^JYBHomeQuickOrderResult)(NSInteger index);

@interface JYBHomeQuickOrderView : UIView

/**
 自定义弹框
 @param action 回调
 @return alertview对象
 */
- (instancetype)initWithArr:(NSMutableArray *)arr clickAction:(JYBHomeQuickOrderResult)action;


/**
 显示
 */
-(void)show;



@end
