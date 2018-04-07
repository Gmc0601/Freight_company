//
//  JYBHomeImproveBoxInfoBottomView.m
//  Freight_Company
//
//  Created by ToneWang on 2018/4/7.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeImproveBoxInfoBottomView.h"
#import "CPConfig.h"

@interface JYBHomeImproveBoxInfoBottomView ()


@property (nonatomic ,strong)UILabel        *desLab;

@property (nonatomic ,strong)UILabel        *priceLab;

@end

@implementation JYBHomeImproveBoxInfoBottomView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self addSubview:self.priceLab];
    [self addSubview:self.priceScheBtn];
    [self addSubview:self.desLab];
    [self addSubview:self.commitBtn];
    
}


- (void)updateBottomView:(CGFloat)price{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"约¥%.2lf",price]];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SizeWidth(15)] range:NSMakeRange(0, 1)];
    [attStr addAttribute:NSForegroundColorAttributeName value:RGB(52, 52, 52) range:NSMakeRange(0, 1)];
    self.priceLab.attributedText = attStr;
    
    if (price) {
        self.desLab.text = [NSString stringWithFormat:@"余额：¥%@",[[CPConfig sharedManager] totalAmount]];
    }else{
        self.desLab.text = @"实际费用可能因等待时间／码头额外费用等因素而变动";
    }

    self.commitBtn.enabled = price <= [[CPConfig sharedManager] totalAmount].floatValue;
}


- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(55))];
        _priceLab.font = [UIFont boldSystemFontOfSize:SizeWidth(20)];
        _priceLab.textColor = RGB(250, 125, 39);
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"约¥0.0"];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SizeWidth(15)] range:NSMakeRange(0, 1)];
        [attStr addAttribute:NSForegroundColorAttributeName value:RGB(52, 52, 52) range:NSMakeRange(0, 1)];
        _priceLab.attributedText = attStr;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.priceLab.bottom, kScreenW, SizeWidth(25))];
        _desLab.font = [UIFont boldSystemFontOfSize:SizeWidth(12)];
        _desLab.textColor = RGB(162, 162, 162);
        _desLab.text = @"实际费用可能因等待时间／码头额外费用等因素而变动";
        _desLab.textAlignment = NSTextAlignmentCenter;
    }
    return _desLab;
}


- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(10), self.desLab.bottom + SizeWidth(10), kScreenW - SizeWidth(20), SizeWidth(40))];
        [_commitBtn setBackgroundImage:[UIImage imageWithColor:RGB(24, 141, 240)] forState:UIControlStateNormal];
        [_commitBtn setBackgroundImage:[UIImage imageWithColor:RGB(208, 208, 208)] forState:UIControlStateDisabled];
        [_commitBtn setTitle:@"确认下单" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.layer.cornerRadius = 2;
        _commitBtn.layer.masksToBounds = YES;
    }
    return _commitBtn;
}


- (UIButton *)priceScheBtn{
    if (!_priceScheBtn) {
        _priceScheBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW - SizeWidth(15) - SizeWidth(80), SizeWidth(15),SizeWidth(80) , SizeWidth(25))];
        [_priceScheBtn setTitle:@"价格明细" forState:UIControlStateNormal];
        [_priceScheBtn setTitleColor:RGB(237, 171, 79) forState:UIControlStateNormal];
        _priceScheBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _priceScheBtn.layer.cornerRadius = 3;
        _priceScheBtn.layer.masksToBounds = YES;
        _priceScheBtn.layer.borderColor = RGB(237, 171, 79).CGColor;
        _priceScheBtn.layer.borderWidth = 1;
    }
    return _priceScheBtn;
}

@end
