//
//  JYBHomeSeleStationHeaderView.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSeleStationHeaderView.h"
#import "UIView+line.h"

@interface JYBHomeSeleStationHeaderView ()


@end

@implementation JYBHomeSeleStationHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self addSubview:self.cityBtn];
    [self addSubview:self.arrowBtn];
    [self addSubview:self.myTextField];
    
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(SizeWidth(65));
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.cityBtn.mas_right);
        make.width.mas_equalTo(SizeWidth(30));
    }];
    [self.myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.arrowBtn.mas_right).offset(SizeWidth(10));
        make.right.equalTo(self).offset(-SizeWidth(90));
    }];

    [self addLineWithInset:UIEdgeInsetsMake(-1, 0, 0, 0)];
}

- (UIButton *)cityBtn{
    if (!_cityBtn) {
        _cityBtn = [[UIButton alloc] init];
        [_cityBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
        [_cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
    }
    return _cityBtn;
}

- (UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        [_arrowBtn setImage:[UIImage imageNamed:@"xzzxd_icon_xl_d"] forState:UIControlStateNormal];
    }
    return _arrowBtn;
}

- (UITextField *)myTextField{
    if (!_myTextField) {
        _myTextField = [[UITextField alloc] init];
        _myTextField.placeholder = @"请选择以下装箱区域";
        _myTextField.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _myTextField.enabled = NO;
    }
    return _myTextField;
}


@end
