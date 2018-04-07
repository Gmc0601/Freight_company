//
//  JYBHomeImproveBoxInfoBottomView.h
//  Freight_Company
//
//  Created by ToneWang on 2018/4/7.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYBHomeImproveBoxInfoBottomView : UIView

@property (nonatomic ,strong)UIButton       *commitBtn;

@property (nonatomic ,strong)UIButton       *priceScheBtn;

- (void)updateBottomView:(CGFloat)price;

@end
