//
//  JYBHomeOtherCostItemCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeOtherCostItemCell.h"

@interface JYBHomeOtherCostItemCell ()

@property (nonatomic ,strong)UILabel *nameLab;

@end

@implementation JYBHomeOtherCostItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_initUI];
        self.contentView.layer.borderColor = RGB(162, 162, 162).CGColor;
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.cornerRadius = 3;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)updateCellWithModel:(JYBHomeDockWeightModel *)model{
    
    if (model.select) {
        self.contentView.layer.borderColor = RGB(75, 157, 252).CGColor;
        self.contentView.layer.borderWidth = 1;
        self.nameLab.textColor = RGB(75, 157, 252);
    }else{
        self.contentView.layer.borderColor = RGB(162, 162, 162).CGColor;
        self.contentView.layer.borderWidth = 1;
        self.nameLab.textColor = RGB(102, 102, 102);
    }
    
    self.nameLab.text = model.weight_desc;

}

- (void)updateDotCellWithModel:(JYBHomeDotModel *)model{
    if (model.select) {
        self.contentView.layer.borderColor = RGB(75, 157, 252).CGColor;
        self.contentView.layer.borderWidth = 1;
        self.nameLab.textColor = RGB(75, 157, 252);
    }else{
        self.contentView.layer.borderColor = RGB(162, 162, 162).CGColor;
        self.contentView.layer.borderWidth = 1;
        self.nameLab.textColor = RGB(102, 102, 102);
    }
    
    self.nameLab.text = model.dock_name;
}

- (void)p_initUI{
    [self.contentView addSubview:self.nameLab];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = RGB(102, 102, 102);
        _nameLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _nameLab.text = @"答谢码头";
        _nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLab;
}


@end
