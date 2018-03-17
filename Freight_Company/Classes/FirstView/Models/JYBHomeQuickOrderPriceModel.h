//
//  JYBHomeQuickOrderPriceModel.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBHomeQuickOrderModel.h"

@interface JYBHomeQuickOrderPriceModel : NSObject

@property (nonatomic ,strong)NSString   *port_price_id;  //港口价格ID

@property (nonatomic ,strong)NSString   *loadarea_id;  //装箱区域ID

@property (nonatomic ,strong)NSString   *port_id;  //港口ID

@property (nonatomic ,strong)JYBHomeQuickOrderModel   *freight_list;  //运价

@property (nonatomic ,strong)JYBHomeQuickOrderModel   *cash_list;  //现金价

@property (nonatomic ,strong)JYBHomeQuickOrderModel   *settlement_list;  //司机结算价

@end
