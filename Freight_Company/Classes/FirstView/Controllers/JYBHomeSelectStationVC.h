//
//  JYBHomeSelectStationVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "JYBHomeStationSeleModel.h"
#import <AMapSearchKit/AMapSearchKit.h>

@protocol JYBHomeSelectStationVCDelegate <NSObject>

@optional
- (void)selectStationModel:(JYBHomeStationSeleModel *)model;

- (void)selectPoint:(AMapTip *)point;

@end

@interface JYBHomeSelectStationVC : CCBaseViewController

@property (nonatomic ,assign)BOOL   isPoint;

@property (nonatomic ,weak)id <JYBHomeSelectStationVCDelegate>delegate;

@property (nonatomic ,strong)NSString   *city;

@property (nonatomic ,strong)NSString   *keyWords;


@end
