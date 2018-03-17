//
//  JYBHomeOtherCostVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "JYBHomeDockWeightModel.h"
#import "JYBHomeDotModel.h"

@protocol JYBHomeOtherCostVCDelegate <NSObject>

- (void)selectWeightModel:(JYBHomeDockWeightModel *)weightModel dotModel:(JYBHomeDotModel *)dotModel;

@end

@interface JYBHomeOtherCostVC : CCBaseViewController

@property(nonatomic ,weak)id <JYBHomeOtherCostVCDelegate>delegate;

@property (nonatomic ,strong)NSString       *prot_id;

@end
