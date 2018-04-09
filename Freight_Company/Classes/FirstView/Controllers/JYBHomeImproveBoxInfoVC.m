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
#import "JYBHomePackAddressListVC.h"
#import "JYBHomeImproveBoxInfoBottomView.h"
#import "CCWebViewViewController.h"
@interface JYBHomeImproveBoxInfoVC ()<UITableViewDelegate,UITableViewDataSource,JYBHomeSendDriveMesgVCDelegate,JYBHomePackAddressListVCDelegate>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)JYBHomeImproveBoxInfoBottomView   *bottomView;

@property (nonatomic, strong) ESPickerView *pickerView;


@end

@implementation JYBHomeImproveBoxInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    if (!self.seleStationArr.count) {
        JYBHomeShipAddressModel *model = [[JYBHomeShipAddressModel alloc] init];
        [self.seleStationArr addObject:model];
    }
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
    
    if (self.seleBoxAddreModel) {
        [self __caluteOrderPrice];
    }
    
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

- (void)selectDriveMessage:(NSString *)message{
    self.seleMessage = message;
    [self.myTableView reloadData];
}

- (void)selectaddressModel:(CPHomeBoxAddressModel *)addressModel{
    self.seleBoxAddreModel = addressModel;
    [self.myTableView reloadData];
    
    //计算价格
    [self __caluteOrderPrice];

}

- (void)selectPointModel:(JYBHomeShipAddressModel *)pointModel indexPaht:(NSIndexPath *)indexPath{
    [self.seleStationArr replaceObjectAtIndex:indexPath.row-1 withObject:pointModel];
    [self.myTableView reloadData];
    
    //计算价格
    [self __caluteOrderPrice];
    
}

- (void)__caluteOrderPrice{
    
    if (!self.seleBoxAddreModel) {
        return;
    }
    BOOL ship = NO;
    for (JYBHomeShipAddressModel *shipModel in self.seleStationArr) {
        if (![NSString stringIsNilOrEmpty:shipModel.shipment_address_id]) {
            ship = YES;
        }
    }
    if (!ship) {
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:self.seleBoxAddreModel.portModel.port_id forKey:@"prot_id"];
    [dic addUnEmptyString:[self __getOrderTypeWithName:self.sepc] forKey:@"order_type"];
    JYBHomeShipAddressModel *firstModel = [self.seleStationArr firstObject];
    [dic addUnEmptyString:firstModel.loadarea_id forKey:@"loadarea_id"];
    
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
            
            [self.bottomView updateBottomView:[datadic[@"data"][@"order_price"] floatValue]];
                        
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (void)priceScheBtnAction{
    
    CCWebViewViewController *vc = [[CCWebViewViewController alloc] init];
    vc.titlestr = @"价格明细";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)commitBtnAction{
    
    if ([NSString stringIsNilOrEmpty:self.startTime]) {
        [ConfigModel mbProgressHUD:@"请选择装箱时间 " andView:nil];
        return;
    }
    if ([NSString stringIsNilOrEmpty:self.endTime]) {
        [ConfigModel mbProgressHUD:@"请选择截关时间时间 " andView:nil];
        return;
    }
    if (!self.seleBoxAddreModel) {
        [ConfigModel mbProgressHUD:@"请选择装箱区域" andView:nil];
        return;
    }
    BOOL ship = NO;
    for (JYBHomeShipAddressModel *shipModel in self.seleStationArr) {
        if (![NSString stringIsNilOrEmpty:shipModel.shipment_address_id]) {
            ship = YES;
        }
    }
    if (!ship) {
        [ConfigModel mbProgressHUD:@"请选择装箱地点" andView:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:self.seleBoxAddreModel.portModel.port_id forKey:@"prot_id"];
    [dic addUnEmptyString:[self __getOrderTypeWithName:self.sepc] forKey:@"order_type"];
    [dic addUnEmptyString:self.startTime forKey:@"shipment_time"];
    [dic addUnEmptyString:self.endTime forKey:@"cutoff_time"];
    [dic addUnEmptyString:self.seleBoxAddreModel.tiOrderNum forKey:@"pick_no"];
    [dic addUnEmptyString:self.seleBoxAddreModel.box_address_id forKey:@"box_address_id"];

    //缺少装箱字段
    JYBHomeShipAddressModel *shipModel = [self.seleStationArr firstObject];
    [dic addUnEmptyString:shipModel.loadarea_id forKey:@"loadarea_id"];
    [dic addUnEmptyString:shipModel.shipment_address_id forKey:@"shipment_address_id"];
    
    [dic addUnEmptyString:self.seleMessage forKey:@"message"];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Order/addOrder" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
            [weak __payOrderWithOrderId:datadic[@"data"][@"order_id"]];
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (void)__payOrderWithOrderId:(NSString *)orderId{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:orderId forKey:@"order_id"];
    
    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Order/payOrder" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JYBOrderNotication" object:nil];
        
        if (weak.tabBarController.selectedIndex == 1) {
            [weak.navigationController popToRootViewControllerAnimated:YES];
        }else{
            weak.tabBarController.selectedIndex = 1;
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
        return self.seleStationArr.count +1;
    }else{
        return 1;
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
            [cell updateCellWithIcon:@"icon_txddz" title:self.seleBoxAddreModel?[NSString stringWithFormat:@"%@\n提单号%@",self.seleBoxAddreModel.portModel.port_name,self.seleBoxAddreModel.tiOrderNum]:@"" placeholder:@"请完善拿箱单地址" editIcon:@"" indexPath:indexPath];
            //区域
        }else{
            //最后一个
            
            JYBHomeShipAddressModel *model = [self.seleStationArr objectAtIndex:indexPath.row -1];
            //已经选中的类型
            [cell updateCellWithIcon:@"icon_nxddz" title:[NSString stringIsNilOrEmpty:model.address]?@"":[NSString stringWithFormat:@"%@\n%@",model.address,model.address_desc] placeholder:@"请选择装箱点地址" editIcon:(indexPath.row  == self.seleStationArr.count)?@"xd_icon_tj":@"xd_icon_sc" indexPath:indexPath];
        }
        WeakSelf(weak)
        [cell setImproveBlock:^(NSIndexPath *indexPath) {
            
            if (indexPath.row == weak.seleStationArr.count) {
                JYBHomeShipAddressModel *model = [[JYBHomeShipAddressModel alloc] init];
                [weak.seleStationArr addObject:model];
                [weak.myTableView reloadData];
                
            }else{

                [weak.seleStationArr removeObjectAtIndex:indexPath.row];
                [weak.myTableView reloadData];

            }
        }];
        
        return cell;
        
    }else{
        JYBHomeInproveBoxInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeInproveBoxInfoCell class]) forIndexPath:indexPath];
        [cell updateCellIcon:@"xd_icon_sjh" Title:@"给司机捎句话" value:self.seleMessage BoxType:JYBHomeInproveBoxNormal indexPath:indexPath];
        return cell;

//        if (indexPath.row == 0) {
//            NSString *wight;
//            if (self.seleDotModel && self.seleWightModel) {
//                wight = [NSString stringWithFormat:@"%@%@",self.seleWightModel.weight_desc,self.seleDotModel.dock_name];
//            }
//            [cell updateCellIcon:@"xd_icon_ewfy" Title:@"额外费用" value:wight BoxType:JYBHomeInproveBoxNormal indexPath:indexPath];
//        }else if (indexPath.row == 1){
//        }else{
//             [cell updateCellIcon:@"xd_icon_yx" Title:@"优先发送给我的司机" value:self.seleDriver.driver_name BoxType:JYBHomeInproveBoxNormal indexPath:indexPath];
//        }

    }
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self __seleTime:indexPath.row];
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            //区域
            JYBHomePackAddressListVC *vc  = [[JYBHomePackAddressListVC alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            //点
            JYBHomePackAddressListVC *vc  = [[JYBHomePackAddressListVC alloc] init];
            vc.delegate = self;
            vc.isPoint = YES;
            vc.indexPath = indexPath;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        if ([NSString stringIsNilOrEmpty:self.seleBoxAddreModel.portModel.port_id]) {
            [ConfigModel mbProgressHUD:@"请先完善拿箱单地址" andView:nil];
            return;
        }
        
        JYBHomeSendDriveMesgVC *vc = [[JYBHomeSendDriveMesgVC alloc] init];
        vc.delegate = self;
        vc.prot_id = self.seleBoxAddreModel.portModel.port_id;
        [self.navigationController pushViewController:vc animated:YES];
        
//        if (indexPath.row == 0) {
//            if (!self.seleBoxAddreModel) {
//                [ConfigModel mbProgressHUD:@"请先完善拿箱单地址" andView:nil];
//                return;
//            }
//            JYBHomeOtherCostVC *vc = [[JYBHomeOtherCostVC alloc] init];
//            vc.prot_id = self.seleBoxAddreModel.portModel.port_id;
//            vc.delegate = self;
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }else if (indexPath.row == 1){
//
//        }else{
//            JYBHomeDriverSelVC *vc = [[JYBHomeDriverSelVC alloc] init];
//            vc.delegate = self;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
    }
}

- (void)__seleTime:(NSInteger)index{
    WeakObj(self);
    NSDate *date = [NSDate dateWithString:(index == 0)?(self.startTime?self.startTime:[self __nextDayAfterDay:1 currntTime:nil]):(self.endTime?self.endTime:[self __nextDataWithCurrrnt:self.startTime]) format:@"yyyy-MM-dd HH:mm:ss"];
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

- (NSString *)__nextDayAfterDay:(NSInteger)day currntTime:(NSString *)current{
    NSDate *currDate = current?[NSDate dateWithString:current format:@"yyyy-MM-dd HH:mm:ss"]:[NSDate date];
    NSDate *date = [currDate dateByAddingDays:1];
    NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *nextStr = [NSString stringWithFormat:@"%@ 08:00:00",[dateStr componentsSeparatedByString:@" "].firstObject];
    return nextStr;
}


- (NSString *)__nextDataWithCurrrnt:(NSString *)current{
    NSDate *currDate = current?[NSDate dateWithString:current format:@"yyyy-MM-dd HH:mm:ss"]:[NSDate date];
    NSDate *date = [currDate dateByAddingDays:1];
    NSString *nextStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    return nextStr;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - SizeWidth(135)) style:UITableViewStyleGrouped];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = RGB(245, 245, 245);
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

- (JYBHomeImproveBoxInfoBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[JYBHomeImproveBoxInfoBottomView alloc] initWithFrame:CGRectMake(0, kScreenH - SizeWidth(135) , kScreenW, SizeWidth(135))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView.commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.priceScheBtn addTarget:self action:@selector(priceScheBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
