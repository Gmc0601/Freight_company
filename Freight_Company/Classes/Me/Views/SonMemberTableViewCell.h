//
//  SonMemberTableViewCell.h
//  Freight_Company
//
//  Created by cc on 2018/1/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SonMemberTableViewCell : UITableViewCell

@property (nonatomic,retain) UIView *addView;

@property (nonatomic, retain) UILabel *nameLab, *phoneLab;

@property (nonatomic, retain) UIButton *delBtn, *changeBtn;

@property (nonatomic, copy) void(^delBlock)();

@property (nonatomic, copy) void(^changeBlock)();

@end
