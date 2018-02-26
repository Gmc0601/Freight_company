//
//  JYBHomePackingInputCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomePackingInputCell.h"

@interface JYBHomePackingInputCell ()

@end

@implementation JYBHomePackingInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.myTextField];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.width.mas_equalTo(SizeWidth(80));
    }];
    
    [self.myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.titleLab.mas_right);
        make.right.equalTo(self.contentView).offset(-SizeWidth(20));
    }];
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, SizeWidth(10), 0, -SizeWidth(10))];

}

- (void)updateCellWithTitle:(NSString *)title placeHoler:(NSString *)placeHoler{
    
    self.titleLab.text = title;
    self.myTextField.placeholder = placeHoler;
    
}

#pragma mark - lazy
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = RGB(52, 52, 52);
        _titleLab.font = [UIFont systemFontOfSize:SizeWidth(15)];
    }
    return _titleLab;
}

- (UITextField *)myTextField{
    if (!_myTextField) {
        _myTextField = [[UITextField alloc] init];
        _myTextField.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _myTextField.textColor = RGB(52, 52, 52);
    }
    return _myTextField;
}


@end
