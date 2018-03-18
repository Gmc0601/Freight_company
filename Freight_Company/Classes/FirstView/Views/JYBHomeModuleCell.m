//
//  JYBHomeModuleCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/10.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeModuleCell.h"


@interface JYBHomeModuleView : UIView

@property (nonatomic ,strong)UIButton *iconImageView;

@property (nonatomic ,strong)UILabel *titleLab;

@property (nonatomic ,strong)UILabel *desLab;

@end

@implementation JYBHomeModuleView

- (instancetype)init{
    if (self = [super init]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.desLab];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.and.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SizeWidth(10));
        make.left.equalTo(self.iconImageView.mas_right);
        make.right.equalTo(self);
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(SizeWidth(10));
        make.left.equalTo(self.iconImageView.mas_right);
        make.right.equalTo(self);
        make.height.mas_equalTo(SizeWidth(15));
    }];
    
}

- (void)updateMoudleWithImg:(NSString *)img title:(NSString *)title des:(NSString *)des{
    [self.iconImageView setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    self.titleLab.text = title;
    self.desLab.text = des;
}

#pragma mark - lazy
- (UIButton *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIButton alloc] init];
        _iconImageView.userInteractionEnabled = NO;
    }
    return _iconImageView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:SizeWidth(15)];
        _titleLab.textColor = RGB(52, 52, 52);
    }
    return _titleLab;
}

- (UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _desLab.textColor = RGB(162, 162, 162);
    }
    return _desLab;
}

@end

@interface JYBHomeModuleCell ()

@end


@implementation JYBHomeModuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self.contentView removeAllSubviews];
    
    NSArray *moudleArr = @[@{@"img":@"sy_icon_xgpc",@"title":@"小柜拼车",@"des":@"1x20GP"},@{@"img":@"sy_icon_xgdf",@"title":@"小柜单放",@"des":@"1x20GP"},@{@"img":@"sy_icon_dg",@"title":@"大柜",@"des":@"1x40GP"},@{@"img":@"sy_icon_gg",@"title":@"高柜",@"des":@"1x40HQ"},@{@"img":@"sy_icon_cgg",@"title":@"超高柜",@"des":@"1x45HQ"},@{@"img":@"sy_icon_htly",@"title":@"海铁联运",@"des":@"1x40HQ"}];
    
    for (int i = 0; i<moudleArr.count; i++) {
        
        JYBHomeModuleView *moudleView = [[JYBHomeModuleView alloc] init];
        [self.contentView addSubview:moudleView];
        [moudleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(SizeWidth(83) * (i/2));
            make.left.equalTo(self.contentView).offset(SizeWidth(10) + ((kScreenW - SizeWidth(30))/2 + SizeWidth(10)) * (i%2));
            make.width.mas_equalTo((kScreenW - SizeWidth(30))/2);
            make.height.mas_equalTo(SizeWidth(73));
        }];
        moudleView.tag = 300+i;
        [moudleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moudleViewClick:)]];
        
        NSDictionary *subDic = moudleArr[i];
        [moudleView updateMoudleWithImg:subDic[@"img"] title:subDic[@"title"]  des:subDic[@"des"]];

    
    }
}

- (void)moudleViewClick:(UIGestureRecognizer *)ges{
    JYBHomeModuleView *view = (JYBHomeModuleView *)ges.view;
    if (self.moudleBlock) {
        self.moudleBlock(view.tag-300);
    }
}

@end
