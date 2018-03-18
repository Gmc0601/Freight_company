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
#import "JYBHomeImproveItemCell.h"
#import "CPHomeBoxAddressModel.h"
#import "JYBImproveFetchBoxVC.h"
#import "JYBHomeEditPacktingListVC.h"

@interface JYBHomeImproveBoxInfoVC ()<UITableViewDelegate,UITableViewDataSource,JYBHomeOtherCostVCDelegate,JYBHomeSendDriveMesgVCDelegate,JYBHomeDriverSelVCDelegate,JYBImproveFetchBoxVCDelegate>

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

@property (nonatomic, strong)NSMutableArray     *seleStationArr;

@property (nonatomic ,strong)CPHomeBoxAddressModel *seleBoxAddreModel;

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
    WeakSelf(weak)
    [[[JYBHomeBoxInfoSpecView alloc] initWithArr:sepcArr.mutableCopy clickAction:^(NSInteger index) {
        weak.sepc = [sepcArr objectAtIndex:index];
        [weak.rightBar setTitle:weak.sepc forState:UIControlStateNormal];

    }] show];
}

- (NSString *)__getOrderTypeWithName:(NSString *)name{
    if ([name isEqualToString:@"1x20GP(拼)"]) {
        return @"small_carpool";
    }else if ([name isEqualToString:@"1x20GP"]){
        return @"small_single";
    }else if ([name isEqualToString:@"1x40GP"]){
        return @"big_cabinet";
    }else if ([name isEqualToString:@"1x40HQ"]){
        return @"tall_cabinet";
    }else{
        return @"super_tall_cabinet";
    }
    
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

- (void)selectBoxAddressModel:(CPHomeBoxAddressModel *)model{
    self.seleBoxAddreModel = model;
    [self.myTableView reloadData];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:model.portModel.port_id forKey:@"port_id"];
    [dic addUnEmptyString:[self __getOrderTypeWithName:self.sepc] forKey:@"order_type"];
    [dic addUnEmptyString:self.loadarea_id forKey:@"loadarea_id"];

    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Order/getOrderPrice" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            self.priceLab.text = [NSString stringWithFormat:@"¥%@",datadic[@"data"][@"order_price"]];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];

}



- (void)commitBtnAction{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:self.seleBoxAddreModel.portModel.port_id forKey:@"port_id"];
    [dic addUnEmptyString:[self __getOrderTypeWithName:self.sepc] forKey:@"order_type"];
    [dic addUnEmptyString:self.startTime forKey:@"shipment_time"];
    [dic addUnEmptyString:self.endTime forKey:@"cutoff_time"];
    [dic addUnEmptyString:self.seleBoxAddreModel.tiOrderNum forKey:@"pick_no"];
    [dic addUnEmptyString:self.seleBoxAddreModel.box_address_id forKey:@"box_address_id"];

    
    [dic addUnEmptyString:nil forKey:@"loadarea_id"];
    [dic addUnEmptyString:nil forKey:@"shipment_address_id"];

    
    [dic addUnEmptyString:self.seleDriver.driver_id forKey:@"driver_id"];
    [dic addUnEmptyString:self.seleMessage forKey:@"message"];
    [dic addUnEmptyString:self.seleDotModel.dock_id forKey:@"dock_id"];
    [dic addUnEmptyString:self.seleWightModel.weight_id forKey:@"weight_id"];

    
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Order/getOrderPrice" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            self.priceLab.text = [NSString stringWithFormat:@"¥%@",datadic[@"data"][@"order_price"]];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
    
    
    
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
        return self.seleStationArr.count +2;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SizeWidth(55);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        JYBHomeInproveBoxInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeInproveBoxInfoCell class]) forIndexPath:indexPath];
        [cell updateCellIcon:@"xx_icon_sj" Title:(indexPath.row == 0)?@"装箱时间":@"截关时间" value:(indexPath.row == 0)?self.startTime:self.endTime BoxType:JYBHomeInproveBoxTime indexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        JYBHomeImproveItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeImproveItemCell class]) forIndexPath:indexPath];

        if (indexPath.row == 0) {
            [cell updateCellWithIcon:@"icon_txddz" title:self.seleBoxAddreModel?[NSString stringWithFormat:@"%@\n%@",self.seleBoxAddreModel.portModel.port_name,self.seleBoxAddreModel.tiOrderNum]:@"" placeholder:@"请完善拿箱单地址" editIcon:@"" indexPath:indexPath];
            //区域
        }else if (indexPath.row == self.seleStationArr.count + 1){
            //最后一个
            [cell updateCellWithIcon:@"icon_nxddz" title:@"" placeholder:@"请选择装箱点地址" editIcon:@"xd_icon_tj" indexPath:indexPath];
        }else{
            //已经选中的类型
            [cell updateCellWithIcon:@"icon_tjnxddz" title:self.seleBoxAddreModel.box_address_desc placeholder:@"请输入拿箱单地址" editIcon:@"xd_icon_sc" indexPath:indexPath];
        }
        WeakSelf(weak)
        [cell setImproveBlock:^(NSIndexPath *indexPath) {
            
            JYBHomeEditPacktingListVC *vc = [[JYBHomeEditPacktingListVC alloc] init];
            [weak.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
        
    }else{
        JYBHomeInproveBoxInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeInproveBoxInfoCell class]) forIndexPath:indexPath];

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
        return cell;

    }
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self __seleTime:indexPath.row];
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            //区域
            JYBImproveFetchBoxVC *vc  = [[JYBImproveFetchBoxVC alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == self.seleStationArr.count + 1){
            //最后一个
            
        }else{
            //已经选中的类型
        }
        
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
            selfWeak.startTime = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        }else{
            selfWeak.endTime = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
        [selfWeak.myTableView reloadData];
        [pickerView animationDismiss];
    }];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - SizeWidth(135)) style:UITableViewStyleGrouped];
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
        [_myTableView registerClass:[JYBHomeImproveItemCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeImproveItemCell class])];

        
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

- (NSMutableArray *)seleStationArr{
    if (!_seleStationArr) {
        _seleStationArr = [[NSMutableArray alloc] init];
    }
    return _seleStationArr;
}

@end
