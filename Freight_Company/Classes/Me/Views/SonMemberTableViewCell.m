//
//  SonMemberTableViewCell.m
//  Freight_Company
//
//  Created by cc on 2018/1/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "SonMemberTableViewCell.h"
#import <YYKit.h>

@implementation SonMemberTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.addView];
        [self.addView addSubview:self.nameLab];
        [self.addView addSubview:self.phoneLab];
        [self.contentView addSubview:self.delBtn];
        [self.contentView addSubview:self.changeBtn];
        
    }
    return self;
}

- (void)update:(SonmemberModel *)model {
    self.nameLab.text = model.company_user_name;
    self.phoneLab.text = model.company_user_phone;
}

- (UIView *)addView {
    if (!_addView) {
        _addView = [[UIView alloc] initWithFrame:FRAME(SizeWidth(10), SizeHeight(5), kScreenW - SizeWidth(20), SizeHeight(64))];
        _addView.backgroundColor = UIColorFromHex(0xF5F5F5);
        _addView.layer.masksToBounds = YES;
        _addView.layer.cornerRadius = 2;
    }
    return _addView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:FRAME(SizeWidth(15), SizeHeight(11.5), kScreenW/2, SizeHeight(17))];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.font = [UIFont boldSystemFontOfSize:18];
        _nameLab.textColor = UIColorFromHex(0x666666);
        _nameLab.text = @"张益达";
    }
    return _nameLab;
}
- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] initWithFrame:FRAME(SizeWidth(15), SizeHeight(40), kScreenW/2, SizeHeight(17))];
        _phoneLab.backgroundColor = [UIColor clearColor];
        _phoneLab.font = [UIFont systemFontOfSize:13];
        _phoneLab.textColor = UIColorFromHex(0x666666);
        _phoneLab.text = @"集运帮八卦吧";
    }
    return _phoneLab;
}

- (void)delClick{
    if (self.delBlock) {
        self.delBlock();
    }
}

- (void)changeClick{
    if (self.changeBlock) {
        self.changeBlock();
    }
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [[UIButton alloc] initWithFrame:FRAME(SizeWidth(240), SizeHeight(28), SizeWidth(40), SizeHeight(20))];
        _delBtn.backgroundColor  = [UIColor clearColor];
        [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
        _delBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_delBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(delClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [[UIButton alloc] initWithFrame:FRAME(self.delBtn.right + SizeWidth(10), SizeHeight(28), SizeWidth(40), SizeHeight(20))];
        _changeBtn.backgroundColor  = [UIColor clearColor];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_changeBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}

@end
