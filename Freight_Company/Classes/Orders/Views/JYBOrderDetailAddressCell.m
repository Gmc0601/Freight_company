//
//  JYBOrderDetailAddressCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//  110

#import "JYBOrderDetailAddressCell.h"

@interface JYBOrderDetailAddressCell ()

@property (nonatomic ,strong)UIView     *dotView;

@property (nonatomic ,strong)UILabel    *nameLab;

@property (nonatomic ,strong)UILabel    *addressTitleLab;

@property (nonatomic ,strong)UILabel    *addressLab;

@property (nonatomic ,strong)UILabel    *contactTitleLab;

@property (nonatomic ,strong)UILabel    *contactLab;

@property (nonatomic ,strong)UIButton   *phoneBtn;

@end

@implementation JYBOrderDetailAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.dotView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.addressTitleLab];
    [self.contentView addSubview:self.addressLab];
    [self.contentView addSubview:self.contactTitleLab];
    [self.contentView addSubview:self.contactLab];
    [self.contactLab addSubview:self.phoneBtn];
    
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SizeWidth(8));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SizeWidth(20));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(15));
        make.left.equalTo(self.dotView.mas_right).offset(SizeWidth(20));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
    [self.addressTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(SizeWidth(10));
        make.left.equalTo(self.dotView.mas_right).offset(SizeWidth(20));
        make.width.mas_equalTo(SizeWidth(75));
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(SizeWidth(10));
        make.left.equalTo(self.addressTitleLab.mas_right).offset(SizeWidth(20));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.height.mas_lessThanOrEqualTo(SizeWidth(40));
    }];
    
    [self.contactTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressTitleLab.mas_top).offset(SizeWidth(40));
        make.left.equalTo(self.dotView.mas_right).offset(SizeWidth(20));
        make.width.mas_equalTo(SizeWidth(75));
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
    [self.contactLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressTitleLab.mas_top).offset(SizeWidth(40));
        make.left.equalTo(self.contactTitleLab.mas_right).offset(SizeWidth(20));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-SizeWidth(5));
        make.width.height.mas_equalTo(SizeWidth(60));
        make.centerY.equalTo(self.contactTitleLab);
    }];
    
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, 0, 0, 0)];
    
}

- (UIView *)dotView{
    if (!_dotView) {
        _dotView = [[UIView alloc] init];
        _dotView.layer.cornerRadius = SizeWidth(4);
        _dotView.layer.masksToBounds = YES;
        _dotView.backgroundColor = RGB(23, 141, 237);
    }
    return _dotView;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _nameLab.textColor = RGB(52, 52, 52);
        _nameLab.text = @"接单号:SSD423424";
    }
    return _nameLab;
}

- (UILabel *)addressTitleLab{
    if (!_addressTitleLab) {
        _addressTitleLab = [[UILabel alloc] init];
        _addressTitleLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _addressTitleLab.textColor = RGB(162, 162, 162);
        _addressTitleLab.text = @"拿箱单地址";
    }
    return _addressTitleLab;
}

- (UILabel *)addressLab{
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] init];
        _addressLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _addressLab.textColor = RGB(162, 162, 162);
        _addressLab.numberOfLines = 0;
        _addressLab.text = @"宁波北仓三期西门3栋5楼503宁波北仓三期西门哇3424擦";
    }
    return _addressLab;
}


- (UILabel *)contactTitleLab{
    if (!_contactTitleLab) {
        _contactTitleLab = [[UILabel alloc] init];
        _contactTitleLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _contactTitleLab.textColor = RGB(162, 162, 162);
        _contactTitleLab.text = @"联系人";
    }
    return _contactTitleLab;
}


- (UILabel *)contactLab{
    if (!_contactLab) {
        _contactLab = [[UILabel alloc] init];
        _contactLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _contactLab.textColor = RGB(162, 162, 162);
        _contactLab.text = @"张下菲";
    }
    return _contactLab;
}


- (UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [[UIButton alloc] init];
        [_phoneBtn setImage:[UIImage imageNamed:@"icon_dh"] forState:UIControlStateNormal];
    }
    return _phoneBtn;
}





@end
