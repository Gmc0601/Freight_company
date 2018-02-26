//
//  JYBHomeSpecItemCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSpecItemCell.h"

@interface JYBHomeSpecItemCell ()

@property (nonatomic ,strong)UILabel    *nameLab;

@property (nonatomic ,strong)UIButton   *iconBtn;

@end

@implementation JYBHomeSpecItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.iconBtn];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).offset(SizeWidth(5));
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(40);
    }];
    
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, 0, 0, 0)];
    
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _nameLab.textColor = RGB(52, 52, 52);
        _nameLab.text = @"1x20GP";
    }
    return _nameLab;
}

- (UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] init];
        [_iconBtn setImage:[UIImage imageNamed:@"xd_icon_p"] forState:UIControlStateNormal];
        _iconBtn.userInteractionEnabled = NO;
    }
    return _iconBtn;
}
@end
