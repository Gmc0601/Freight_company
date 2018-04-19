//
//  JYBHomeSelePointAddCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/4/19.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSelePointAddCell.h"

@interface JYBHomeSelePointAddCell ()


@end

@implementation JYBHomeSelePointAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.nameDetailLab];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(10));
        make.left.equalTo(self.contentView).offset(SizeWidth(20));
        make.right.equalTo(self.contentView).offset(-SizeWidth(20));
        make.height.mas_equalTo(SizeWidth(30));
    }];
    
    [self.nameDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom);
        make.left.equalTo(self.contentView).offset(SizeWidth(20));
        make.right.equalTo(self.contentView).offset(-SizeWidth(20));
        make.height.mas_equalTo(SizeWidth(25));
    }];
    
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, SizeWidth(20), 0, -SizeWidth(20))];
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = RGB(52, 52, 52);
        _nameLab.font = [UIFont systemFontOfSize:SizeWidth(15)];
    }
    return _nameLab;
}


- (UILabel *)nameDetailLab{
    if (!_nameDetailLab) {
        _nameDetailLab = [[UILabel alloc] init];
        _nameDetailLab.textColor = RGB(162, 162, 162);
        _nameDetailLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
    }
    return _nameDetailLab;
}

@end
