//
//  JYBHomeOtherCostItemCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeOtherCostItemCell.h"

@interface JYBHomeOtherCostItemCell ()

@property (nonatomic ,strong)UILabel *nameLab;

@property (nonatomic ,strong)UILabel *costLab;

@end

@implementation JYBHomeOtherCostItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_initUI];
        self.contentView.layer.borderColor = RGB(162, 162, 162).CGColor;
        self.contentView.layer.borderWidth = 1;
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.costLab];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(10));
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
    [self.costLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(SizeWidth(5));
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(SizeWidth(15));
    }];
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = RGB(102, 102, 102);
        _nameLab.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _nameLab.text = @"答谢码头";
        _nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLab;
}

- (UILabel *)costLab{
    if (!_costLab) {
        _costLab = [[UILabel alloc] init];
        _costLab.textColor = RGB(162, 162, 162);
        _costLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _costLab.text = @"32434";
        _costLab.textAlignment = NSTextAlignmentCenter;

    }
    return _costLab;
}

@end
