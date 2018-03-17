//
//  JYBHomeSelectStationVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "JYBHomeStationSeleModel.h"

@protocol JYBHomeSelectStationVCDelegate <NSObject>

- (void)selectStationModel:(JYBHomeStationSeleModel *)model;

@end

@interface JYBHomeSelectStationVC : CCBaseViewController

@property (nonatomic ,weak)id <JYBHomeSelectStationVCDelegate>delegate;

@end
