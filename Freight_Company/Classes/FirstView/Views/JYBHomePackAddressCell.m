//
//  JYBHomePackAddressCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//  85

#import "JYBHomePackAddressCell.h"
#import "UIView+line.h"

@interface JYBHomePackAddressCell ()

@property (nonatomic ,strong)UIButton       *nameLab;

@property (nonatomic ,strong)UIButton       *phoneLab;

@property (nonatomic ,strong)UIButton       *addressLab;

@property (nonatomic ,strong)UIButton       *deleBtn;

@property (nonatomic ,strong)UIButton       *editBtn;

@property (nonatomic, strong)id addressModel;

@end

@implementation JYBHomePackAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.phoneLab];
    [self.contentView addSubview:self.addressLab];
    [self.contentView addSubview:self.deleBtn];
    [self.contentView addSubview:self.editBtn];


    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(10));
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.right.equalTo(self.contentView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(25));
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(35));
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.right.equalTo(self.contentView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(25));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(60));
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.right.equalTo(self.contentView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(25));
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-SizeWidth(15));
        make.width.mas_equalTo(SizeWidth(60));
        make.height.mas_equalTo(SizeWidth(25));
        make.bottom.equalTo(self.contentView).offset(-SizeWidth(10));
    }];
    
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editBtn.mas_left).offset(-SizeWidth(15));
        make.width.mas_equalTo(SizeWidth(60));
        make.height.mas_equalTo(SizeWidth(25));
        make.bottom.equalTo(self.contentView).offset(-SizeWidth(10));
    }];
    
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, 0, 0, 0)];
    
}

- (void)updateCellWithModel:(CPHomeBoxAddressModel *)model{
    
    self.addressModel = model;
    
    [self.nameLab setTitle:[NSString stringWithFormat:@" %@",model.box_linkman] forState:UIControlStateNormal];
    [self.phoneLab setTitle:[NSString stringWithFormat:@" %@",model.box_linkman_phone] forState:UIControlStateNormal];
    [self.addressLab setTitle:[NSString stringWithFormat:@" %@",model.box_address_desc] forState:UIControlStateNormal];
}

- (void)updatePointCellWithModel:(JYBHomeShipAddressModel *)model{
    self.addressModel = model;

    [self.nameLab setTitle:model.shipment_linkman forState:UIControlStateNormal];
    [self.phoneLab setTitle:model.shipment_linkman_phone forState:UIControlStateNormal];
    [self.addressLab setTitle:model.address forState:UIControlStateNormal];

}

#pragma mark - lazy


- (UIButton *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UIButton alloc] init];
        _nameLab.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(13)];
        [_nameLab setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        _nameLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _nameLab.userInteractionEnabled = NO;
        [_nameLab setImage:[UIImage imageNamed:@"ic_man"] forState:UIControlStateNormal];

    }
    return _nameLab;
}


- (UIButton *)phoneLab{
    if (!_phoneLab) {
        _phoneLab = [[UIButton alloc] init];
        _phoneLab.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(13)];
        [_phoneLab setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        _phoneLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _phoneLab.userInteractionEnabled = NO;
        [_phoneLab setImage:[UIImage imageNamed:@"ic_phone"] forState:UIControlStateNormal];

    }
    return _phoneLab;
}


- (UIButton *)addressLab{
    if (!_addressLab) {
        _addressLab = [[UIButton alloc] init];
        _addressLab.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(13)];
        [_addressLab setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        _addressLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _addressLab.userInteractionEnabled = NO;
        [_addressLab setImage:[UIImage imageNamed:@"ic_address"] forState:UIControlStateNormal];
    }
    return _addressLab;
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
