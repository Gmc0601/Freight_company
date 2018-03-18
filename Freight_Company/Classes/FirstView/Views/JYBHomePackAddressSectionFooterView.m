//
//  JYBHomePackAddressSectionFooterView.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//  50

#import "JYBHomePackAddressSectionFooterView.h"

@interface JYBHomePackAddressSectionFooterView ()

@property (nonatomic ,strong)UIButton       *deleBtn;

@property (nonatomic ,strong)UIButton       *editBtn;

@end

@implementation JYBHomePackAddressSectionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self.contentView addSubview:self.deleBtn];
    [self.contentView addSubview:self.editBtn];
    
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-SizeWidth(15));
        make.width.mas_equalTo(SizeWidth(60));
        make.height.mas_equalTo(SizeWidth(30));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editBtn.mas_left).offset(-SizeWidth(15));
        make.width.mas_equalTo(SizeWidth(60));
        make.height.mas_equalTo(SizeWidth(30));
        make.centerY.equalTo(self.contentView);
    }];

}

- (void)deleBtnAction{
    if (self.deleBlock) {
        self.deleBlock(self.addressModel);
    }
}

- (void)editBtnAction{
    if (self.editBlock) {
        self.editBlock(self.addressModel);
    }
}

- (UIButton *)deleBtn{
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc] init];
        [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        _deleBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _deleBtn.layer.cornerRadius = SizeWidth(15);
        _deleBtn.layer.masksToBounds = YES;
        _deleBtn.layer.borderColor = RGB(102, 102, 102).CGColor;
        _deleBtn.layer.borderWidth = 1;
        [_deleBtn addTarget:self action:@selector(deleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleBtn;
}

- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] init];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _editBtn.layer.cornerRadius = SizeWidth(15);
        _editBtn.layer.masksToBounds = YES;
        _editBtn.layer.borderColor = RGB(102, 102, 102).CGColor;
        _editBtn.layer.borderWidth = 1;
        [_editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}


@end
