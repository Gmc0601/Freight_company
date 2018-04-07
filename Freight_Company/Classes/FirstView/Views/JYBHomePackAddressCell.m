//
//  JYBHomePackAddressCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//  85

#import "JYBHomePackAddressCell.h"

@interface JYBHomePackAddressCell ()

@property (nonatomic ,strong)UIView         *backView;

@property (nonatomic ,strong)UIButton       *nameLab;

@property (nonatomic ,strong)UIButton       *phoneLab;

@property (nonatomic ,strong)UIButton       *addressLab;

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
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.nameLab];
    [self.backView addSubview:self.phoneLab];
    [self.backView addSubview:self.addressLab];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(5));
        make.bottom.equalTo(self.contentView).offset(-SizeWidth(5));
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView);
        make.left.equalTo(self.backView).offset(SizeWidth(15));
        make.right.equalTo(self.backView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(25));
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(25));
        make.left.equalTo(self.backView).offset(SizeWidth(15));
        make.right.equalTo(self.backView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(25));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(50));
        make.left.equalTo(self.backView).offset(SizeWidth(15));
        make.right.equalTo(self.backView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(25));
    }];
}

- (void)updateCellWithModel:(CPHomeBoxAddressModel *)model{
    
    [self.nameLab setTitle:[NSString stringWithFormat:@" %@",model.box_linkman] forState:UIControlStateNormal];
    [self.phoneLab setTitle:[NSString stringWithFormat:@" %@",model.box_linkman_phone] forState:UIControlStateNormal];
    [self.addressLab setTitle:[NSString stringWithFormat:@" %@",model.box_address_desc] forState:UIControlStateNormal];
}

- (void)updatePointCellWithModel:(JYBHomeShipAddressModel *)model{
    
    [self.nameLab setTitle:model.shipment_linkman forState:UIControlStateNormal];
    [self.phoneLab setTitle:model.shipment_linkman_phone forState:UIControlStateNormal];
    [self.addressLab setTitle:model.address forState:UIControlStateNormal];

}

#pragma mark - lazy
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(245, 246, 245);
        _backView.layer.cornerRadius = 3;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}


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

@end
