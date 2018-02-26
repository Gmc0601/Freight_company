//
//  JYBHomeManageFetchBoxCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeManageFetchBoxCell.h"

@interface JYBHomeManageFetchBoxCell ()

@property (nonatomic ,strong)UIView *backView;

@property (nonatomic ,strong)UILabel *nameLabel;

@property (nonatomic ,strong)UILabel *addressLab;

@property (nonatomic ,strong)UIButton *deleBtn;

@property (nonatomic ,strong)UIButton *editBtn;

@end

@implementation JYBHomeManageFetchBoxCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.addressLab];
    [self.contentView addSubview:self.deleBtn];
    [self.contentView addSubview:self.editBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (self.contentView).offset(SizeWidth(10));
        make.top.equalTo (self.contentView).offset(SizeWidth(10));
        make.right.equalTo (self.contentView).offset(-SizeWidth(10));
        make.bottom.equalTo(self.deleBtn.mas_top).offset(-SizeWidth(10));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (self.backView).offset(SizeWidth(10));
        make.top.equalTo (self.backView).offset(SizeWidth(10));
        make.right.equalTo (self.backView).offset(-SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(13));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.nameLabel.mas_bottom).offset(SizeWidth(10));
        make.left.equalTo (self.backView).offset(SizeWidth(10));
        make.right.equalTo (self.backView).offset(-SizeWidth(10));
        make.height.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.bottom.equalTo(self.backView).offset(-SizeWidth(10));
    }];
    
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).offset(SizeWidth(10));
        make.right.equalTo(self.editBtn.mas_left).offset(-SizeWidth(10));
        make.width.mas_equalTo(SizeWidth(60));
        make.height.mas_equalTo(SizeWidth(30));
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).offset(SizeWidth(10));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.width.mas_equalTo(SizeWidth(60));
        make.height.mas_equalTo(SizeWidth(30));
    }];
    
    
}

- (void)deleBtnAction{
    if (self.deleBlock) {
        self.deleBlock();
    }
}

- (void)editBtnAction{
    if (self.editBlock) {
        self.editBlock();
    }
}


#pragma mark - lazy
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(245, 245, 245);
    }
    return _backView;
}

- (UILabel *)nameLabel{
    if (_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = RGB(162, 162, 162);
        _nameLabel.font = [UIFont systemFontOfSize:SizeWidth(13)];
    }
    return _nameLabel;
}

- (UILabel *)addressLab{
    if (_addressLab) {
        _addressLab = [[UILabel alloc] init];
        _addressLab.textColor = RGB(162, 162, 162);
        _addressLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _addressLab.numberOfLines = 0;
    }
    return _addressLab;
}

- (UIButton *)deleBtn{
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc] init];
        [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
        [_deleBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(deleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleBtn;
}

- (UIButton *)editBtn{
    if (_editBtn) {
        _editBtn = [[UIButton alloc] init];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
        [_editBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

@end
