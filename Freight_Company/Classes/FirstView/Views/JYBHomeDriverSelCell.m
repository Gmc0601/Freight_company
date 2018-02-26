//
//  JYBHomeDriverSelCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeDriverSelCell.h"

@interface JYBHomeDriverSelCell ()

@property (nonatomic ,strong)UIView  *backView;

@property (nonatomic ,strong)UILabel *nameLab;

@property (nonatomic ,strong)UILabel *desLab;

@property (nonatomic ,strong)UILabel *numLab;


@end

@implementation JYBHomeDriverSelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.nameLab];
    [self.backView addSubview:self.desLab];
    [self.backView addSubview:self.numLab];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SizeWidth(5));
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(65));
    }];
    
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(10));
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(SizeWidth(10));
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(SizeWidth(10));
        make.right.equalTo(self.backView).offset(-SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(16));
    }];
    
}


#pragma mark - lazy
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(245, 245, 245);
    }
    return _backView;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont boldSystemFontOfSize:SizeWidth(16)];
        _nameLab.textColor = RGB(102, 102, 102);
        _nameLab.text = @"张世达";
    }
    return _nameLab;
}

- (UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _desLab.textColor = RGB(102, 102, 102);
        _desLab.text = @"集运邦车队";
    }
    return _desLab;
}

- (UILabel *)numLab{
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.font = [UIFont boldSystemFontOfSize:SizeWidth(16)];
        _numLab.textColor = RGB(102, 102, 102);
        _numLab.text = @"挂A 59403";
    }
    return _numLab;
}



@end
