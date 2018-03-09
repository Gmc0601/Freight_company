//
//  JYBPortSelectCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBPortSelectCell.h"

@interface JYBPortSelectCell ()

@property (nonatomic ,strong)UIView         *backView;

@property (nonatomic ,strong)UIButton       *commitBtn;

@property (nonatomic ,strong)UILabel        *portLabel;

@property (nonatomic ,strong)UIButton       *portSeleBtn;

@property (nonatomic ,strong)UIButton       *portStationBtn;

@end

@implementation JYBPortSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.commitBtn];
    
    [self.backView addSubview:self.portLabel];
    [self.backView addSubview:self.portSeleBtn];
    [self.backView addSubview:self.portStationBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.top.offset(SizeWidth(15));
        make.bottom.offset(-SizeWidth(15));
        make.width.mas_equalTo(kScreenW - SizeWidth(110));
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SizeWidth(10));
        make.top.offset(SizeWidth(17));
        make.bottom.offset(-SizeWidth(17));
        make.width.mas_equalTo(SizeWidth(80));
    }];
    
    [self.portLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.backView);
        make.left.offset(SizeWidth(10));
        make.width.mas_equalTo(SizeWidth(70));
    }];
    
    [self.portSeleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.backView);
        make.left.equalTo(self.portLabel.mas_right).offset(SizeWidth(5));
        make.width.mas_equalTo(SizeWidth(40));
    }];
    
    [self.portStationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.backView);
        make.right.offset(-SizeWidth(15));
        make.left.equalTo(self.portSeleBtn.mas_right).offset(SizeWidth(20));
    }];
    
    
}

- (void)updateCellWithPort:(NSString *)port station:(NSString *)station{
    
    self.portLabel.text = port;
    [self.portStationBtn setTitle:[NSString stringIsNilOrEmpty:station]?@"请输入装箱地点":station forState:UIControlStateNormal];
}

- (void)commitBtnAction{
    if (self.commitBlock) {
        self.commitBlock();
    }
}

- (void)portSeleBtnAction{
    if (self.selectBlock) {
        self.selectBlock();
    }
}

- (void)portStationBtnAction{
    if (self.stationBlock) {
        self.stationBlock();
    }
}


- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.borderColor = RGB(162, 162, 162).CGColor;
        _backView.layer.borderWidth = 1;
    }
    return _backView;
}

- (UILabel *)portLabel{
    if (!_portLabel) {
        _portLabel = [[UILabel alloc] init];
        _portLabel.textColor = RGB(52, 52, 52);
        _portLabel.font = [UIFont systemFontOfSize:SizeWidth(15)];
    }
    return _portLabel;
}

- (UIButton *)portSeleBtn{
    if (!_portSeleBtn) {
        _portSeleBtn = [[UIButton alloc] init];
        [_portSeleBtn setImage:[UIImage imageNamed:@"icon_jh"] forState:UIControlStateNormal];
        [_portSeleBtn addTarget:self action:@selector(portSeleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _portSeleBtn;
}

- (UIButton *)portStationBtn{
    if (!_portStationBtn) {
        _portStationBtn = [[UIButton alloc] init];
        [_portStationBtn setTitle:@"请输入装箱地点" forState:UIControlStateNormal];
        [_portStationBtn setTitleColor:RGB(203, 203, 203) forState:UIControlStateNormal];
        _portStationBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _portStationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_portStationBtn addTarget:self action:@selector(portStationBtnAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _portStationBtn;
}

- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] init];
        [_commitBtn setTitle:@"运价查询" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(14)];
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.backgroundColor = RGB(24, 141, 239);
    }
    return _commitBtn;
}

@end