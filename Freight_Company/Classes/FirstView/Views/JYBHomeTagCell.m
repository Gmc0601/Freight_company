//
//  JYBHomeTagCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeTagCell.h"

@interface JYBHomeTagCell ()

@end


@implementation JYBHomeTagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{

    [self.contentView removeAllSubviews];
    
    NSArray *titleArr = @[@" 优选司机",@" 优惠价格",@" 实时定位",@" 全程保险"];
    for (int i = 0; i<titleArr.count; i++) {
        UIButton *aBtn = [self p_crateBtnTitle:titleArr[i]];
        [self.contentView addSubview:aBtn];
        [aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(kScreenW/4);
            make.left.equalTo(self.contentView).offset(kScreenW/4*i);
        }];
    }
}

- (UIButton *)p_crateBtnTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGB(162, 162, 126) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(13)];
    [btn setImage:[UIImage imageNamed:@"sy_sign_td"] forState:UIControlStateNormal];
    return btn;
}

@end
