//
//  CPHomeMyDriverModel.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPHomeMyDriverModel : NSObject

@property (nonatomic ,strong)NSString   *driver_id;  //司机ID

@property (nonatomic ,strong)NSString   *driver_phone;  //    司机电话

@property (nonatomic ,strong)NSString   *driver_name;  //司机名称

@property (nonatomic ,strong)NSString   *car_no;  //车牌

@property (nonatomic ,strong)NSString   *fleet_id;  //所属车队ID

@property (nonatomic ,strong)NSString   *fleet_name;  //所属车队名称

@end
