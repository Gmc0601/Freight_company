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
    [self addSubview:self.searchBtn];
    
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
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SizeWidth(40));
        make.width.mas_equalTo(SizeWidth(70));
        make.right.equalTo(self).offset(-SizeWidth(10));
        make.centerY.equalTo(self);
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
        _myTextField.placeholder = @"输入集箱点,如绍兴";
        _myTextField.font = [UIFont systemFontOfSize:SizeWidth(15)];
    }
    return _myTextField;
}

- (UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _searchBtn.backgroundColor = RGB(246, 246, 246);
        _searchBtn.layer.cornerRadius = 3;
        _arrowBtn.layer.masksToBounds = YES;
    }
    return _searchBtn;
}

@end
