//
//  JYBHomeManageFetchBoxCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JYBHomeManageFetchBoxDeleBlock)();

typedef void(^JYBHomeManageFetchBoxEditBlock)();

@interface JYBHomeManageFetchBoxCell : UITableViewCell

@property (nonatomic ,copy)JYBHomeManageFetchBoxDeleBlock deleBlock;

@property (nonatomic ,copy)JYBHomeManageFetchBoxEditBlock editBlock;

@end
