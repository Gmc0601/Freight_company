//
//  JYBHomeImproveBoxInfoVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CPHomeBoxAddressModel.h"

@interface JYBHomeImproveBoxInfoVC : CCBaseViewController

@property (nonatomic ,strong)NSString   *sepc;

@property (nonatomic ,strong)NSString *startTime;

@property (nonatomic ,strong)NSString *endTime;

@property (nonatomic ,strong)NSString       *seleMessage;

@property (nonatomic, strong)NSMutableArray     *seleStationArr;

@property (nonatomic ,strong)CPHomeBoxAddressModel *seleBoxAddreModel;

@end
