//
//  JYBHomeDockWeightModel.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBHomeDockWeightModel : NSObject

@property (nonatomic ,strong)NSString   *weight_id;  //货重ID

@property (nonatomic ,strong)NSString   *port_id;  //港口ID

@property (nonatomic ,strong)NSString   *weight_desc;  //货重描述

@property (nonatomic ,strong)NSString   *weight_price;  //货重对应价格

@property (nonatomic ,strong)NSString   *create_time;  //

@property (nonatomic ,assign)BOOL       select;

@end
