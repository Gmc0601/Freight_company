//
//  JYBHomePackAddressCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomePackAddressCell.h"

@interface JYBHomePackAddressCell ()

@property (nonatomic ,strong)UIView         *backView;

@property (nonatomic ,strong)UILabel       *nameLab;

@property (nonatomic ,strong)UILabel       *addressLab;

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
    [self.backView addSubview:self.addressLab];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(5));
        make.bottom.equalTo(self.contentView).offset(-SizeWidth(5));
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(13));
        make.left.equalTo(self.backView).offset(SizeWidth(15));
        make.right.equalTo(self.backView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(13));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(SizeWidth(8));
        make.left.equalTo(self.backView).offset(SizeWidth(15));
        make.right.equalTo(self.backView).offset(-SizeWidth(15));
        make.bottom.equalTo(self.backView).offset(-SizeWidth(15));
    }];
}

- (void)updateCellWithModel:(CPHomeBoxAddressModel *)model{
    
    self.nameLab.text = [NSString stringWithFormat:@"%@%@",model.box_linkman,model.box_linkman_phone];
    self.addressLab.text = model.box_address_desc;
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


- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _nameLab.textColor = RGB(52, 52, 52);
        _nameLab.text = @"3refer爽肤水方法";
    }
    return _nameLab;
}

- (UILabel *)addressLab{
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] init];
        _addressLab.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _addressLab.textColor = RGB(52, 52, 52);
        _addressLab.numberOfLines = 0;
        _addressLab.text = @"3refer爽肤水方法";
    }
    return _addressLab;
}

@end
