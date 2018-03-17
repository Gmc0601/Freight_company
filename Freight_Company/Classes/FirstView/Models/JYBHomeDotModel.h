//
//  JYBHomeDotModel.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBHomeDotModel : NSObject

@property (nonatomic ,strong)NSString   *dock_id;  //码头ID

@property (nonatomic ,strong)NSString   *port_id;  //港口ID

@property (nonatomic ,strong)NSString   *dock_name;  //码头名

@property (nonatomic ,strong)NSString   *dock_price;  //进港费

@property (nonatomic ,assign)BOOL       select;

@end
