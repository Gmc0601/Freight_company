//
//  CPHomeBoxAddressModel.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPHomeBoxAddressModel : NSObject

@property (nonatomic ,strong)NSString   *box_address_id;  //拿箱地址ID

@property (nonatomic ,strong)NSString   *user_id;  //创建人user_id

@property (nonatomic ,strong)NSString   *box_linkman;  //联系人姓名

@property (nonatomic ,strong)NSString   *box_linkman_phone;  //联系人电话

@property (nonatomic ,strong)NSString   *box_address_desc;  //拿箱地址

@property (nonatomic ,strong)NSString   *create_time;  //司机ID

@property (nonatomic ,strong)NSString   *is_use;  //是否常用地址 0-否 1-是

@property (nonatomic ,strong)NSString   *is_delete;  //是否删除 0-否 1-是

@end
