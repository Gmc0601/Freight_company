
//
//  JYBHomeInproveBoxInfoCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeInproveBoxInfoCell.h"
#import "UIView+line.h"

@interface JYBHomeInproveBoxInfoCell ()

@property (nonatomic ,strong)UIButton   *iconBtn;

@property (nonatomic ,strong)UILabel    *titleLab;

@property (nonatomic ,strong)UIButton   *arrowBtn;

@property (nonatomic ,strong)UILabel    *desLab;

@end

@implementation JYBHomeInproveBoxInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.iconBtn];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.arrowBtn];
    [self.contentView addSubview:self.desLab];
    
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(55);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.iconBtn.mas_right);
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-SizeWidth(5));
        make.width.mas_equalTo(SizeWidth(30));
    }];
    
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.arrowBtn.mas_left);
        make.left.equalTo(self.titleLab.mas_right).offset(10);
    }];
    
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, SizeWidth(15), 0, -SizeWidth(15))];
    
}

- (void)updateCellIcon:(NSString *)icon Title:(NSString *)title value:(NSString *)value BoxType:(JYBHomeInproveBoxType)type indexPath:(NSIndexPath *)indexPath{
    
    [self.iconBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    if (type == JYBHomeInproveBoxTime) {
        self.titleLab.text = title;
        self.desLab.textColor = [NSString stringIsNilOrEmpty:value]?RGB(162, 162, 162):RGB(52, 52, 52);
        self.desLab.text = [NSString stringIsNilOrEmpty:value]?@"选择时间":value;
        
    }else{
        self.titleLab.text = title;
        self.desLab.textColor = [NSString stringIsNilOrEmpty:value]?RGB(162, 162, 162):RGB(52, 52, 52);
        self.desLab.text = [NSString stringIsNilOrEmpty:value]?@"货重，特殊情况等":value;

//        if (indexPath.row == 0) {
//            self.desLab.text = [NSString stringIsNilOrEmpty:value]?@"重量、码头等费用":value;
//        }else if (indexPath.row ==1){
//        }else{
//            self.desLab.text = [NSString stringIsNilOrEmpty:value]?@"选择我的司机":value;
//        }

    }
}
#pragma mark - lazy
- (UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] init];
    }
    return _iconBtn;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:SizeWidth(16)];
        _titleLab.textColor = RGB(52, 52, 52);
    }
    return _titleLab;
}

- (UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        [_arrowBtn setImage:[UIImage imageNamed:@"icon_gd"] forState:UIControlStateNormal];
        _arrowBtn.userInteractionEnabled = NO;
    }
    return _arrowBtn;
}

- (UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _desLab.textColor = RGB(162, 162, 162);
        _desLab.textAlignment = NSTextAlignmentRight;
    }
    return _desLab;
}

@end
