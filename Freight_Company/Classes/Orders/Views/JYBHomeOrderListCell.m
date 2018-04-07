//
//  JYBHomeOrderListCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeOrderListCell.h"
#import "JYBOrderBoxAddressModel.h"
#import "JYBOrderListModel.h"

@interface JYBHomeOrderListCell ()

@property (nonatomic ,strong)UIView *backView;

@property (nonatomic ,strong)UILabel *statusLab;

@property (nonatomic ,strong)UILabel *priceLab;

@property (nonatomic ,strong)UIView *conView;

@property (nonatomic ,strong)UILabel *startLab;

@property (nonatomic ,strong)UILabel *endLab;

@property (nonatomic ,strong)UIButton *lineBtn;

@property (nonatomic ,strong)UILabel *startTimeLab;

@property (nonatomic ,strong)UILabel *endTimeLab;

@property (nonatomic ,strong)UILabel *orderNumLab;

@property (nonatomic ,strong)UIButton *leftBtn;

@property (nonatomic ,strong)UIButton *rightBtn;

@property (nonatomic ,strong)JYBOrderListModel *listModel;

@end

@implementation JYBHomeOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGB(246, 246, 246);
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.backView];
    
    [self.backView addSubview:self.statusLab];
    [self.backView addSubview:self.priceLab];
    [self.backView addSubview:self.conView];
    
    [self.conView addSubview:self.startLab];
    [self.conView addSubview:self.endLab];
    [self.conView addSubview:self.lineBtn];
    [self.conView addSubview:self.startTimeLab];
    [self.conView addSubview:self.endTimeLab];
    
    [self.backView addSubview:self.orderNumLab];
    [self.backView addSubview:self.leftBtn];
    [self.backView addSubview:self.rightBtn];

    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.right.equalTo(self.contentView).offset(-SizeWidth(10));
        make.top.equalTo(self.contentView).offset(SizeWidth(15));
        make.height.mas_equalTo(SizeWidth(175));
    }];
    
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView);
        make.height.mas_equalTo(SizeWidth(30));
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView);
        make.height.mas_equalTo(SizeWidth(30));
        make.right.equalTo(self.backView).offset(-SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    [self.conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLab.mas_bottom);
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.right.equalTo(self.backView).offset(-SizeWidth(10));
        make.height.mas_equalTo(SizeWidth(100));
    }];
    
    [self.startLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conView).offset(SizeWidth(15));
        make.height.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.left.equalTo(self.conView).offset(SizeWidth(15));
        make.width.mas_equalTo((kScreenW - SizeWidth(100))/2);
    }];
    
    [self.endLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conView).offset(SizeWidth(15));
        make.height.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.right.equalTo(self.conView).offset(-SizeWidth(15));
        make.width.mas_equalTo((kScreenW - SizeWidth(100))/2);
    }];
    
    
    [self.lineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.conView);
        make.width.mas_equalTo(SizeWidth(50));
        make.height.mas_equalTo(SizeWidth(30));
        
    }];
    
    [self.startTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conView).offset(SizeWidth(60));
        make.height.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.left.equalTo(self.conView).offset(SizeWidth(15));
        make.width.mas_equalTo((kScreenW - SizeWidth(100))/2);
    }];
    
    [self.endTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conView).offset(SizeWidth(60));
        make.height.mas_greaterThanOrEqualTo(SizeWidth(10));
        make.right.equalTo(self.conView).offset(-SizeWidth(15));
        make.width.mas_equalTo((kScreenW - SizeWidth(100))/2);
    }];
    
    [self.orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conView.mas_bottom);
        make.height.mas_equalTo(SizeWidth(45));
        make.left.equalTo(self.backView).offset(SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conView.mas_bottom).offset(SizeWidth(11));
        make.right.equalTo(self.rightBtn.mas_left).offset(-SizeWidth(10));
        make.width.mas_equalTo(SizeWidth(65));
        make.height.mas_equalTo(SizeWidth(22));
        
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conView.mas_bottom).offset(SizeWidth(11));
        make.right.equalTo(self.backView).offset(-SizeWidth(10));
        make.width.mas_equalTo(SizeWidth(65));
        make.height.mas_equalTo(SizeWidth(22));
    }];
    
    
}

- (void)udpateCellWithModel:(JYBOrderListModel *)listModel{
    
    self.listModel = listModel;
    
    self.statusLab.text = [self __getOrderStatus:listModel.order_status.integerValue];
    
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",listModel.order_price];
    
    self.startLab.text = [NSString stringWithFormat:@"%@ %@",listModel.port_name,listModel.dock_name?listModel.dock_name:@""];
    if (listModel.shipment_address.count) {
        JYBOrderBoxAddressModel *firstModel = [listModel.shipment_address firstObject];
        self.endLab.text = firstModel.loadarea_name;
    }
    
    self.startTimeLab.text = [NSString stringWithFormat:@"装箱时间\n%@",listModel.shipment_time];
    self.endTimeLab.text = [NSString stringWithFormat:@"闭关时间\n%@",listModel.cutoff_time];

    self.orderNumLab.text = [NSString stringWithFormat:@"提单号: %@",listModel.pick_no];
}

- (NSString *)__getOrderStatus:(NSInteger)status{
    
    //订单状态 状态：0-待支付 10-派单中 20-已接单 30-进行中 40-已到港（待支付,支付额外费用） 50-已完成 60-已取消
    
    switch (status) {
        case 0:
        {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"确认费用" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(55, 164, 242) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(55, 164, 242).CGColor;
            return @"待确认";
        }
            //支付
            break;
        case 10:
        {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"再次下单" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
            return @"派单中";

        }
            //再次下单
            break;
        case 20:
        {
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.leftBtn setTitle:@"再次下单" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            self.leftBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
            [self.rightBtn setTitle:@"联系司机" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(55, 164, 242) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(55, 164, 242).CGColor;
            return @"已接单";

        }
            //再次下单 。 联系司机
            break;
        case 30:
        {
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.leftBtn setTitle:@"再次下单" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            self.leftBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
            [self.rightBtn setTitle:@"联系司机" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(55, 164, 242) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(55, 164, 242).CGColor;
            return @"进行中";
        }
            //再次下单 。 联系司机
            break;
        case 31:
        {
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.leftBtn setTitle:@"再次下单" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            self.leftBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
            [self.rightBtn setTitle:@"联系司机" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(55, 164, 242) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(55, 164, 242).CGColor;
            return @"已到港待支付(额外费用待审核)";
        }
            //再次下单 。 联系司机
            break;
        case 40:
        {
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = NO;
            [self.leftBtn setTitle:@"再次下单" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            self.leftBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
            [self.rightBtn setTitle:@"联系司机" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(55, 164, 242) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(55, 164, 242).CGColor;
            return @"已到港";
        }
            //再次下单 。 联系司机
            break;
        case 50:
        {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"再次下单" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
            return @"已完成";

        }
            //再次下单
            break;
        case 60:
        {
            self.leftBtn.hidden = YES;
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:@"再次下单" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
            return @"已取消";
        }
            //再次下单
            break;
        default:
            return @"";
            break;
    }
}


- (void)leftBtnAction{
    if (self.listBlock) {
        self.listBlock(JYBHomeOrderListActionOrder,self.listModel);
    }
}

- (void)rightBtnAction{
    
    JYBHomeOrderListAction action;
    switch (self.listModel.order_status.integerValue) {
        case 0:
            action = JYBHomeOrderListActionPay;
            //支付
            break;
        case 10:
            action = JYBHomeOrderListActionOrder;
            //再次下单
            break;
        case 20:
            action = JYBHomeOrderListActionContact;
            //再次下单 。 联系司机
            break;
        case 30:
            action = JYBHomeOrderListActionContact;
            //再次下单 。 联系司机
            break;
        case 40:
            action = JYBHomeOrderListActionContact;
            //再次下单 。 联系司机
            break;
        case 50:
            action = JYBHomeOrderListActionOrder;
            //再次下单
            break;
        case 60:
            action = JYBHomeOrderListActionOrder;
            //再次下单
            break;
        default:
            action = JYBHomeOrderListActionOrder;
            break;
    }
    if (self.listBlock) {
        self.listBlock(action,self.listModel);
    }
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)statusLab{
    if (!_statusLab) {
        _statusLab = [[UILabel alloc] init];
        _statusLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _statusLab.textColor = RGB(55, 164, 242);
        _statusLab.text = @"排单中";
    }
    return _statusLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _priceLab.textColor = RGB(102, 102, 102);
        _priceLab.textAlignment = NSTextAlignmentRight;
        _priceLab.text = @"¥ 1200.00";
    }
    return _priceLab;
}

- (UIView *)conView{
    if (!_conView) {
        _conView = [[UIView alloc] init];
        _conView.backgroundColor = RGB(237, 248, 254);
    }
    return _conView;
}

- (UILabel *)startLab{
    if (!_startLab) {
        _startLab = [[UILabel alloc] init];
        _startLab.font = [UIFont boldSystemFontOfSize:SizeWidth(16)];
        _startLab.textColor = [UIColor blackColor];
        _startLab.numberOfLines = 0;
//        _startLab.text = @"宁波港 北仓三期码头";
    }
    return _startLab;
}

- (UILabel *)endLab{
    if (!_endLab) {
        _endLab = [[UILabel alloc] init];
        _endLab.font = [UIFont systemFontOfSize:SizeWidth(16)];
        _endLab.textColor = [UIColor blackColor];
        _endLab.numberOfLines = 0;
//        _endLab.text = @"宁波港 北仓三期码头";
        _endLab.textAlignment = NSTextAlignmentRight;
    }
    return _endLab;
}

- (UIButton *)lineBtn{
    if (!_lineBtn) {
        _lineBtn = [[UIButton alloc] init];
        [_lineBtn setImage:[UIImage imageNamed:@"dd_icon_jt"] forState:UIControlStateNormal];
        _lineBtn.userInteractionEnabled = NO;
    }
    return _lineBtn;
}

- (UILabel *)startTimeLab{
    if (!_startTimeLab) {
        _startTimeLab = [[UILabel alloc] init];
        _startTimeLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _startTimeLab.textColor = RGB(162, 162, 162);
        _startTimeLab.numberOfLines = 0;
        _startTimeLab.text = @"装箱时间\n2017-12-12 10:00";
//        _startTimeLab.textAlignment = NSTextAlignmentRight;

    }
    return _startTimeLab;
}

- (UILabel *)endTimeLab{
    if (!_endTimeLab) {
        _endTimeLab = [[UILabel alloc] init];
        _endTimeLab.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _endTimeLab.textColor = RGB(162, 162, 162);
        _endTimeLab.numberOfLines = 0;
        _endTimeLab.textAlignment = NSTextAlignmentRight;
        _endTimeLab.text = @"装箱时间\n2017-12-12 10:00";

    }
    return _endTimeLab;
}


- (UILabel *)orderNumLab{
    if (!_orderNumLab) {
        _orderNumLab = [[UILabel alloc] init];
        _orderNumLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
        _orderNumLab.textColor = RGB(102, 102, 102);
        _orderNumLab.text = @"提单号: GS2343534546";
    }
    return _orderNumLab;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setTitle:@"再次下单" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(12)];
        [_leftBtn setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
        _leftBtn.layer.borderColor = RGB(52, 52, 52).CGColor;
        _leftBtn.layer.borderWidth = 1;
        _leftBtn.layer.cornerRadius = SizeWidth(10);
        _leftBtn.layer.masksToBounds = YES;
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:@"联系司机" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:SizeWidth(12)];
        [_rightBtn setTitleColor:RGB(55, 164, 242) forState:UIControlStateNormal];
        _rightBtn.layer.borderColor = RGB(55, 164, 242).CGColor;
        _rightBtn.layer.borderWidth = 1;
        _rightBtn.layer.cornerRadius = SizeWidth(10);
        _rightBtn.layer.masksToBounds = YES;
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

@end
