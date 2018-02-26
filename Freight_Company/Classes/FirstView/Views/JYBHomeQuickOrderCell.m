
//
//  JYBHomeQuickOrderCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeQuickOrderCell.h"

@interface JYBHomeQuickOrderCell ()

@property (nonatomic ,strong)UIView  *backView;

@property (nonatomic ,strong)UILabel *nameLab;

@property (nonatomic ,strong)UILabel *desLab;

@property (nonatomic ,strong)UILabel *priceTitleLab;

@property (nonatomic ,strong)UILabel *priceLab;

@property (nonatomic ,strong)UILabel *originPriceLab;

@end

@implementation JYBHomeQuickOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.nameLab];
    [self.backView addSubview:self.desLab];
    [self.backView addSubview:self.priceLab];
    [self.backView addSubview:self.priceTitleLab];
    [self.backView addSubview:self.originPriceLab];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(5));
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(65));
    }];
    
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(10));
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(SizeWidth(10));
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(10));
        make.right.equalTo(self.backView).offset(-SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
    [self.priceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(10));
        make.right.equalTo(self.priceLab.mas_left).offset(-SizeWidth(3));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
    [self.originPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLab.mas_bottom).offset(SizeWidth(10));
        make.right.equalTo(self.backView).offset(-SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
}


#pragma mark - lazy
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(249, 249, 249);
    }
    return _backView;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont boldSystemFontOfSize:SizeWidth(15)];
        _nameLab.textColor = RGB(52, 52, 52);
        _nameLab.text = @"小柜拼车";
    }
    return _nameLab;
}

- (UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.font = [UIFont boldSystemFontOfSize:SizeWidth(13)];
        _desLab.textColor = RGB(162, 162, 162);
        _desLab.text = @"1x20GP";
    }
    return _desLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont boldSystemFontOfSize:SizeWidth(16)];
        _priceLab.textColor = RGB(253, 125, 39);
        _priceLab.text = @"¥4245";

    }
    return _priceLab;
}

- (UILabel *)priceTitleLab{
    if (!_priceTitleLab) {
        _priceTitleLab = [[UILabel alloc] init];
        _priceTitleLab.font = [UIFont boldSystemFontOfSize:SizeWidth(13)];
        _priceTitleLab.textColor = RGB(52, 52, 52);
        _priceTitleLab.text = @"运价";
    }
    return _priceTitleLab;
}

- (UILabel *)originPriceLab{
    if (!_originPriceLab) {
        _originPriceLab = [[UILabel alloc] init];
        _originPriceLab.font = [UIFont boldSystemFontOfSize:SizeWidth(12)];
        _originPriceLab.textColor = RGB(162, 162, 162);
        _originPriceLab.text = @"现金价：¥3445";

    }
    return _originPriceLab;
}


@end
