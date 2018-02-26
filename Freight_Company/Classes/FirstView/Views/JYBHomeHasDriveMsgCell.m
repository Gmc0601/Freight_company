//
//  JYBHomeHasDriveMsgCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeHasDriveMsgCell.h"

@interface JYBHomeHasDriveMsgCell ()

@property (nonatomic ,strong)UIView *backView;

@end

@implementation JYBHomeHasDriveMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.contentLab];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView).offset(SizeWidth(5));
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.bottom.equalTo(self.contentView).offset(-SizeWidth(5));

    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(10));
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.right.equalTo(self.backView).offset(-SizeWidth(10));
        make.bottom.equalTo(self.backView).offset(-SizeWidth(10));
    }];
    
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(245, 245, 245);
    }
    return _backView;
}

- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = RGB(162, 162, 162);
        _contentLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

@end
