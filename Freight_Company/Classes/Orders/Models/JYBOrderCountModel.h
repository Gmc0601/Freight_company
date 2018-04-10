//
//  JYBOrderCountModel.h
//  Freight_Company
//
//  Created by ToneWang on 2018/4/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBOrderCountModel : NSObject

@property (nonatomic,copy)NSString *wait_pay;      //待支付

@property (nonatomic,copy)NSString *allotting;      //派单中

@property (nonatomic,copy)NSString *allotted;      // 已接单

@property (nonatomic,copy)NSString *under_way;      //进行中

@property (nonatomic,copy)NSString *second_wait_pay;      //已进港，待支付

@end
