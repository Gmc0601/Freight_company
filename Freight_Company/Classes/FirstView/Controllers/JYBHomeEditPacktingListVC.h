//
//  JYBHomeEditPacktingListVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"

@protocol JYBHomeEditPacktingDelegate <NSObject>

- (void)portPackStationSel:(NSString *)packStation;

@end

@interface JYBHomeEditPacktingListVC : CCBaseViewController

@property (nonatomic ,weak)id <JYBHomeEditPacktingDelegate>delegate;

@end
