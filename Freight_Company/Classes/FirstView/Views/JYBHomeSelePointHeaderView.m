//
//  JYBHomeSelePointHeaderView.m
//  Freight_Company
//
//  Created by ToneWang on 2018/4/7.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSelePointHeaderView.h"
#import "UIView+line.h"

@interface JYBHomeSelePointHeaderView ()<UITextFieldDelegate>

@property (nonatomic ,strong)UIView *lineView;

@end


@implementation JYBHomeSelePointHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self addSubview:self.cityBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.myTextField];
    
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(SizeWidth(110));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SizeWidth(10));
        make.bottom.equalTo(self).offset(-SizeWidth(10));
        make.left.equalTo(self.cityBtn.mas_right);
        make.width.mas_equalTo(1);
    }];

    [self.myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.cityBtn.mas_right).offset(SizeWidth(10));
        make.right.equalTo(self).offset(-SizeWidth(10));
    }];
    
    [self addLineWithInset:UIEdgeInsetsMake(-1, 0, 0, 0)];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [self.myTextField endEditing:YES];
//    if (self.headerSearchBlock) {
//        self.headerSearchBlock(textField.text);
//    }
//    return YES;
//}



- (UIButton *)cityBtn{
    if (!_cityBtn) {
        _cityBtn = [[UIButton alloc] init];
        [_cityBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
    }
    return _cityBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(162, 162, 162);
    }
    return _lineView;
}


- (UITextField *)myTextField{
    if (!_myTextField) {
        _myTextField = [[UITextField alloc] init];
        _myTextField.placeholder = @"请输入装箱地点，如xx路xx号";
        _myTextField.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _myTextField.returnKeyType = UIReturnKeySearch;
        _myTextField.delegate = self;
    }
    return _myTextField;
}


@end
