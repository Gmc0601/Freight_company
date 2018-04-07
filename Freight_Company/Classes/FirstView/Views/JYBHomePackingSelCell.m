//
//  JYBHomePackingSelCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomePackingSelCell.h"

@interface JYBHomePackingSelCell ()

@property (nonatomic ,strong)UILabel *titleLab;

@property (nonatomic ,strong)UILabel *resultLab;

@property (nonatomic ,strong)UIButton *arrowBtn;

@property (nonatomic ,strong)NSIndexPath *indexPath;

@end

@implementation JYBHomePackingSelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.resultLab];
    [self.contentView addSubview:self.arrowBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SizeWidth(15));
        make.width.mas_equalTo(SizeWidth(100));
    }];
    
    [self.resultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.arrowBtn.mas_left);
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.width.mas_equalTo(SizeWidth(20));
    }];
    
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, SizeWidth(10), 0, -SizeWidth(10))];
    
}

- (void)updateCellWithTitle:(NSString *)title result:(NSString *)result indexPath:(NSIndexPath *)indexPath{
    
    self.indexPath = indexPath;
    self.titleLab.text = title;
    self.resultLab.text = [NSString stringIsNilOrEmpty:result]?((indexPath.row == 0)?@"请选择装箱区域":@"请选择装箱地点"):result;
    self.resultLab.textColor = [NSString stringIsNilOrEmpty:result]?RGB(203, 203, 203):RGB(52, 52, 52);
    
}

- (void)arrowBtnAction{
    if (self.selBlock) {
        self.selBlock(self.indexPath);
    }
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

- (UILabel *)resultLab{
    if (!_resultLab) {
        _resultLab = [[UILabel alloc] init];
        _resultLab.textColor = RGB(52, 52, 52);
        _resultLab.font = [UIFont systemFontOfSize:SizeWidth(15)];
        _resultLab.textAlignment = NSTextAlignmentRight;
    }
    return _resultLab;
}

- (UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        [_arrowBtn setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
        _arrowBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
        [_arrowBtn setImage:[UIImage imageNamed:@"icon_gd"] forState:UIControlStateNormal];
        [_arrowBtn addTarget:self action:@selector(arrowBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}


@end
