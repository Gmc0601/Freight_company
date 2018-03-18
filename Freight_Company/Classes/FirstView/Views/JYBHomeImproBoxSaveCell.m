//
//  JYBHomeImproBoxSaveCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeImproBoxSaveCell.h"

@interface JYBHomeImproBoxSaveCell ()

@property (nonatomic ,strong)UILabel    *titleLab;

@end

@implementation JYBHomeImproBoxSaveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.seleBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    [self.seleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.width.mas_equalTo(SizeWidth(55));
    }];
    
}

- (void)seleBtnAction{
    if (self.saveBlock) {
        self.saveBlock();
    }
}


- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = RGB(102, 102, 102);
        _titleLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _titleLab.text = @"保存为常用拿箱单地址";
    }
    return _titleLab;
}

- (UIButton *)seleBtn{
    if (!_seleBtn) {
        _seleBtn = [[UIButton alloc] init];
        [_seleBtn setImage:[UIImage imageNamed:@"icon_xz"] forState:UIControlStateNormal];
        [_seleBtn setImage:[UIImage imageNamed:@"icon_xz_pre"] forState:UIControlStateSelected];
        [_seleBtn addTarget:self action:@selector(seleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seleBtn;
}

@end
