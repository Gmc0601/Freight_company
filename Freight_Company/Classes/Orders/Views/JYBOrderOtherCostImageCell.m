//
//  JYBOrderOtherCostImageCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/14.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBOrderOtherCostImageCell.h"

@interface JYBOrderOtherCostImageCell ()

@property (nonatomic ,strong)UILabel    *titleLab;


@end


@implementation JYBOrderOtherCostImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(20));
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.right.equalTo(self.contentView).offset(-SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = RGB(52, 52, 52);
        _titleLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _titleLab.text = @"其他费用凭证";
    }
    return _titleLab;
}

@end
