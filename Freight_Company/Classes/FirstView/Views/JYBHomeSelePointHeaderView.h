//
//  JYBHomeSelePointHeaderView.h
//  Freight_Company
//
//  Created by ToneWang on 2018/4/7.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYBHomeSelePointHeaderSearchBlock)(NSString *keyWord);

@interface JYBHomeSelePointHeaderView : UIView

@property (nonatomic ,copy)JYBHomeSelePointHeaderSearchBlock headerSearchBlock;

@property (nonatomic ,strong)UIButton       *cityBtn;

@property (nonatomic ,strong)UITextField    *myTextField;

@end
