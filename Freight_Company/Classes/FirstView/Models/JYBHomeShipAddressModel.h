//
//  JYBHomeShipAddressModel.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBHomeShipAddressModel : NSObject

@property (nonatomic ,strong)NSString   *shipment_address_id;  //装箱点ID

@property (nonatomic ,strong)NSString   *province;  //省

@property (nonatomic ,strong)NSString   *city;  //省

@property (nonatomic ,strong)NSString   *address;  //装箱点地址

@property (nonatomic ,strong)NSString   *address_desc;  //装箱点地址

@property (nonatomic ,strong)NSString   *lon;  //

@property (nonatomic ,strong)NSString   *lat;  //

@property (nonatomic ,strong)NSString   *shipment_linkman;  //装箱点联系人

@property (nonatomic ,strong)NSString   *shipment_linkman_phone;  //联系方式

@property (nonatomic ,strong)NSString   *loadarea_name;  // 区域名字

@property (nonatomic ,strong)NSString   *loadarea_id;  //   区域id

@end
