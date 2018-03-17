//
//  JYBHomeSeleStaionCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSeleStaionCell.h"
#import "UIView+line.h"

@interface JYBHomeSeleStaionCell ()


@end

@implementation JYBHomeSeleStaionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SizeWidth(20));
        make.right.equalTo(self.contentView).offset(-SizeWidth(20));
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

@end
