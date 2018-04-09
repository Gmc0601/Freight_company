//
//  JYBHomeFetchBoxPortCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeFetchBoxPortCell.h"
#import "UIView+line.h"

@interface JYBHomeFetchBoxPortCell ()

@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UIButton   *arrowBtn;

@end


@implementation JYBHomeFetchBoxPortCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self.contentView addSubview:self.portLab];
    [self.contentView addSubview:self.arrowBtn];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.myTextFeild];
    
    [self.portLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.width.mas_equalTo(SizeWidth(75));
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.portLab.mas_right);
        make.width.mas_equalTo(SizeWidth(20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(10));
        make.bottom.equalTo(self.contentView).offset(-SizeWidth(10));
        make.left.mas_equalTo(SizeWidth(110));
        make.width.mas_equalTo(1);
    }];
    
    [self.myTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.mas_equalTo(SizeWidth(120));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
    }];
    
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, SizeWidth(15), 0, -SizeWidth(15))];
}

- (void)portLabAction{
    if (self.boxPortBlock) {
        self.boxPortBlock();
    }
}

- (UIButton *)portLab{
    if (!_portLab) {
        _portLab = [[UIButton alloc] init];
        [_portLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _portLab.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(16)];
        [_portLab addTarget:self action:@selector(portLabAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _portLab;
}


- (UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        [_arrowBtn setImage:[UIImage imageNamed:@"jyb_arrow_down"] forState:UIControlStateNormal];
        [_arrowBtn addTarget:self action:@selector(portLabAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}

- (UITextField *)myTextFeild{
    if (!_myTextFeild) {
        _myTextFeild = [[UITextField alloc] init];
        _myTextFeild.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _myTextFeild.textColor = RGB(52, 52, 52);
        _myTextFeild.placeholder = @"请输入提单号(必填)";
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(20), SizeWidth(20))];
        [leftBtn setImage:[UIImage imageNamed:@"bi"] forState:UIControlStateNormal];
        _myTextFeild.leftView = leftBtn;
        _myTextFeild.leftViewMode = UITextFieldViewModeAlways;
        _myTextFeild.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    return _myTextFeild;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(162, 162, 162);
    }
    return _lineView;
}


@end
