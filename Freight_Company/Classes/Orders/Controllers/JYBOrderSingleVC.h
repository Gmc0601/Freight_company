//
//  JYBOrderSingleVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    JYBOrderTypeAll,
    JYBOrderTypeWait,
    JYBOrderTypePai,
    JYBOrderTypeReviced,
    JYBOrderTypeIng,
} JYBOrderType;

@interface JYBOrderSingleVC : BaseViewController

@property (nonatomic ,assign)JYBOrderType   type;

@end
