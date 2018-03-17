//
//  JYBHomeImproveBoxInfoVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeImproveBoxInfoVC.h"
#import "JYBHomeInproveBoxInfoCell.h"
#import "ESPickerView.h"
#import "AppDelegate.h"
#import "JYBHomeDriverSelVC.h"
#import "JYBHomeSendDriveMesgVC.h"
#import "JYBHomeOtherCostVC.h"
#import "JYBHomeBoxInfoSpecView.h"

@interface JYBHomeImproveBoxInfoVC ()<UITableViewDelegate,UITableViewDataSource,JYBHomeOtherCostVCDelegate,JYBHomeSendDriveMesgVCDelegate,JYBHomeDriverSelVCDelegate>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)UILabel    *priceLab;

@property (nonatomic, strong) ESPickerView *pickerView;

@property (nonatomic ,strong)NSString *startTime;

@property (nonatomic ,strong)NSString *endTime;

@property (nonatomic ,strong)JYBHomeDockWeightModel *seleWightModel;

@property (nonatomic ,strong)JYBHomeDotModel *seleDotModel;

@property (nonatomic ,strong)NSString       *seleMessage;

@property (nonatomic ,strong)CPHomeMyDriverModel *seleDriver;
@end

@implementation JYBHomeImproveBoxInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
}

- (void)resetFather {
    self.titleLab.text = @"完善装箱信息";
    [self.rightBar setTitle:self.sepc forState:UIControlStateNormal];
    
}


- (void)more:(UIButton *)sender{
    
    NSArray *sepcArr = @[@"1x20GP(拼)",@"1x20GP",@"1x40GP",@"1x40HQ",@"1x45HQ"];

    [[[JYBHomeBoxInfoSpecView alloc] initWithArr:sepcArr.mutableCopy clickAction:^(NSInteger index) {
        NSString *sepx = [sepcArr objectAtIndex:index];
        [self.rightBar setTitle:sepx forState:UIControlStateNormal];

    }] show];
}

- (void)selectWeightModel:(JYBHomeDockWeightModel *)weightModel dotModel:(JYBHomeDotModel *)dotModel{
    self.seleWightModel = weightModel;
    self.seleDotModel = dotModel;
    [self.myTableView reloadData];
    
}

- (void)selectDriveMessage:(NSString *)message{
    self.seleMessage = message;
    [self.myTableView reloadData];
}

- (void)selectDriverModel:(CPHomeMyDriverModel *)driverModel{
    self.seleDriver = driverModel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SizeWidth(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 0;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SizeWidth(55);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYBHomeInproveBoxInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeInproveBoxInfoCell class]) forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [cell updateCellIcon:@"xx_icon_sj" Title:(indexPath.row == 0)?@"装箱时间":@"截关时间" value:(indexPath.row == 0)?self.startTime:self.endTime BoxType:JYBHomeInproveBoxTime indexPath:indexPath];
    }else if (indexPath.section == 1){
        
    }else{
        if (indexPath.row == 0) {
            NSString *wight;
            if (self.seleDotModel && self.seleWightModel) {
                wight = [NSString stringWithFormat:@"%@%@",self.seleWightModel.weight_desc,self.seleDotModel.dock_name];
            }
            [cell updateCellIcon:@"xd_icon_ewfy" Title:@"额外费用" value:wight BoxType:JYBHomeInproveBoxNormal indexPath:indexPath];
        }else if (indexPath.row == 1){
             [cell updateCellIcon:@"xd_icon_sjh" Title:@"给司机捎句话" value:self.seleMessage BoxType:JYBHomeInproveBoxNormal indexPath:indexPath];
        }else{
             [cell updateCellIcon:@"xd_icon_yx" Title:@"优先发送给我的司机" value:self.seleDriver.fleet_name BoxType:JYBHomeInproveBoxNormal indexPath:indexPath];
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self __seleTime:indexPath.row];
    }else if (indexPath.section == 1){
        
    }else{
        if (indexPath.row == 0) {
            JYBHomeOtherCostVC *vc = [[JYBHomeOtherCostVC alloc] init];
            vc.prot_id = self.prot_id;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 1){
            JYBHomeSendDriveMesgVC *vc = [[JYBHomeSendDriveMesgVC alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            JYBHomeDriverSelVC *vc = [[JYBHomeDriverSelVC alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)__seleTime:(NSInteger)index{
    WeakObj(self);
    NSDate *date = [NSDate dateWithString:(index == 0)?self.startTime:self.endTime format:@"yyyy-MM-dd HH:mm"];
    [self.pickerView animationShowWithDate:date maximumDate:nil minimumDate:nil selectedItemComplete:^(ESPickerView *pickerView, NSString *item, NSDate *date) {
        if (index == 0) {
            selfWeak.startTime = [date stringWithFormat:@"yyyy-MM-dd HH:mm"];
        }else{
            selfWeak.endTime = [date stringWithFormat:@"yyyy-MM-dd HH:mm"];
        }
        [selfWeak.myTableView reloadData];
        [pickerView animationDismiss];
    }];
}


- (void)commitBtnAction{
    
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - SizeWidth(135)) style:UITableViewStylePlain];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[JYBHomeInproveBoxInfoCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeInproveBoxInfoCell class])];
    }
    return _myTableView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - SizeWidth(135) , kScreenW, SizeWidth(135))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(55))];
        self.priceLab.font = [UIFont boldSystemFontOfSize:SizeWidth(18)];
        self.priceLab.textColor = RGB(250, 125, 39);
        self.priceLab.text = @"¥0";
        self.priceLab.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:self.priceLab];
        
        UILabel *desLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.priceLab.bottom, kScreenW, SizeWidth(25))];
        desLab.font = [UIFont boldSystemFontOfSize:SizeWidth(12)];
        desLab.textColor = RGB(162, 162, 162);
        desLab.text = @"实际费用可能因等待时间／码头额外费用等因素而变动";
        desLab.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:desLab];
        
        UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(10), desLab.bottom + SizeWidth(10), kScreenW - SizeWidth(20), SizeWidth(40))];
        commitBtn.backgroundColor = RGB(24, 141, 240);
        [commitBtn setTitle:@"确认下单" forState:UIControlStateNormal];
        [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commitBtn.layer.cornerRadius = 2;
        commitBtn.layer.masksToBounds = YES;
        [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:commitBtn];
    }
    return _bottomView;
}

- (ESPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[ESPickerView alloc] init];
        _pickerView.hidden = YES;
        AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow *keyWindow =appDelegate.window;
        [keyWindow addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(keyWindow);
        }];
        [keyWindow layoutIfNeeded];
    }
    return _pickerView;
}
@end
