//
//  JYBHomeFetchBoxPortCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYBHomeFetchBoxPortBlock)();

@interface JYBHomeFetchBoxPortCell : UITableViewCell

@property (nonatomic ,copy)JYBHomeFetchBoxPortBlock boxPortBlock;

@property (nonatomic ,strong)UIButton        *portLab;

@property (nonatomic ,strong)UITextField    *myTextFeild;

@end
