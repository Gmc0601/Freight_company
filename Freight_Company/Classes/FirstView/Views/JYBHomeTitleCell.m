//
//  JYBHomeTitleCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeTitleCell.h"

@interface JYBHomeTitleCell ()

@property (nonatomic ,strong)UILabel *titleLab;

@end

@implementation JYBHomeTitleCell

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
        make.edges.equalTo(self.contentView);
    }];
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = RGB(52, 52, 52);
        _titleLab.font = [UIFont systemFontOfSize:SizeWidth(18)];
        _titleLab.text = @"快速下单";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}


@end
