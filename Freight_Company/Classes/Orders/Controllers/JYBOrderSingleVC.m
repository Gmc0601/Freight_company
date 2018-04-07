//
//  JYBOrderSingleVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBOrderSingleVC.h"
#import "JYBHomeOrderListCell.h"
#import "JYBOrderPayPopView.h"
#import "JYBOrderDetailVC.h"
#import "JYBOrderListModel.h"
#import "TBRefresh.h"
#import "CPConfig.h"
#import "JYBHomeImproveBoxInfoVC.h"
#import "JYBOrderBoxAddressModel.h"
#import "JYBHomeShipAddressModel.h"

@interface JYBOrderSingleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)NSMutableArray *dataArr;

@property (nonatomic ,assign)NSInteger  currentPage;
@end

@implementation JYBOrderSingleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self.view addSubview:self.myTableView];
    
    [self __fetchOrderList];
}

- (void)__fetchOrderList{
    
//    JYBOrderTypeAll,      //
//    JYBOrderTypeHasPai,   //已接单
//    JYBOrderTypeIng,      //进行中
//    JYBOrderTypeReviced,  //已到港
    
    NSString *status;
    if (self.type == JYBOrderTypeAll) {
        status = @"";
    }else if (self.type == JYBOrderTypeHasPai){
        status = @"20";
    }else if (self.type == JYBOrderTypeIng){
        status = @"30";
    }else{
        status = @"40";
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:status forKey:@"order_status"];
    [dic addUnEmptyString:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [dic addUnEmptyString:@"10" forKey:@"size"];

    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Order/orderList" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        [weak.myTableView.header endHeadRefresh];
        [weak.myTableView.footer endFooterRefreshing];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            if (weak.currentPage == 1) {
                [weak.dataArr removeAllObjects];
            }
            for (NSDictionary *subDic in datadic[@"data"]) {
                JYBOrderListModel *model = [JYBOrderListModel modelWithDictionary:subDic];
                [weak.dataArr addObject:model];
            }
            [weak.myTableView reloadData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SizeWidth(190);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYBHomeOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeOrderListCell class]) forIndexPath:indexPath];
    JYBOrderListModel *model = [self.dataArr objectAtIndex:indexPath.row];
    [cell udpateCellWithModel:model];
    WeakObj(self);
    [cell setListBlock:^(JYBHomeOrderListAction action,JYBOrderListModel *listModel) {
        if (action == JYBHomeOrderListActionContact) {
            [selfWeak __phoneWithModel:listModel];
        }else if (action == JYBHomeOrderListActionOrder){
            [selfWeak __orderWithModel:listModel];
        }else{
            [selfWeak __payWithModel:listModel];
        }
    }];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYBOrderListModel *model = [self.dataArr objectAtIndex:indexPath.row];
    JYBOrderDetailVC *vc = [[JYBOrderDetailVC alloc] init];
    vc.order_id = model.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)__phoneWithModel:(JYBOrderListModel *)listModel{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确认拨打\n%@",listModel.driver_phone] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",listModel.driver_phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)__orderWithModel:(JYBOrderListModel *)model{
    JYBHomeImproveBoxInfoVC *vc = [[JYBHomeImproveBoxInfoVC alloc] init];
    vc.startTime = model.shipment_time;
    vc.endTime = model.cutoff_time;
    vc.seleMessage = model.message;
    vc.sepc = [self __getSpec:model.order_type];
    CPHomeBoxAddressModel *boxAddressModel = [[CPHomeBoxAddressModel alloc] init];
    boxAddressModel.box_address_id = model.box_address_id;
    boxAddressModel.tiOrderNum = model.pick_no;
    JYBHomePortModel *portModel = [[JYBHomePortModel alloc] init];
    portModel.port_id = model.port_id;
    portModel.port_name = model.port_name;
    boxAddressModel.portModel = portModel;
    vc.seleBoxAddreModel = boxAddressModel;

    NSMutableArray *shipArr = [[NSMutableArray alloc] init];
    for (JYBOrderBoxAddressModel *shipModel in model.shipment_address) {
        JYBHomeShipAddressModel *model = [[JYBHomeShipAddressModel alloc] init];
        
        model.shipment_address_id = shipModel.shipment_address_id;
        model.province = shipModel.province;
        model.city = shipModel.city;
        model.address = shipModel.address;
        model.address_desc = shipModel.address_desc;
        model.lon = shipModel.lon;
        model.lat = shipModel.lat;
        model.shipment_linkman = shipModel.shipment_linkman;
        model.shipment_linkman_phone = shipModel.shipment_linkman_phone;
        model.loadarea_name = shipModel.loadarea_name;
        model.loadarea_id = shipModel.loadarea_id;
        
        [shipArr addObject:model];
    }
    vc.seleStationArr = shipArr;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)__getSpec:(NSString *)sepc{
    
    if ([sepc isEqualToString:@"small_carpool"]) {
        return @"1x20GP(拼)";
    }else if ([sepc isEqualToString:@"small_single"]){
        return @"1x20GP";
    }else if ([sepc isEqualToString:@"big_cabinet"]){
        return @"1x40GP";
    }else if ([sepc isEqualToString:@"tall_cabinet"]){
        return @"1x40HQ";
    }else{
        return @"1x45HQ";
    }
}


- (void)__payWithModel:(JYBOrderListModel *)model{
    WeakObj(self);
    [[[JYBOrderPayPopView alloc] initWithPayAmount:model.order_price.floatValue totalAmount:[[CPConfig sharedManager] totalAmount].floatValue ClickAction:^{
        [selfWeak __payOrderWithModel:model];

    }] show];
}


- (void)__payOrderWithModel:(JYBOrderListModel *)model{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:model.order_id forKey:@"order_id"];
    
    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Order/payOrder" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        [weak.myTableView.header endHeadRefresh];
        [weak.myTableView.footer endFooterRefreshing];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
            weak.currentPage = 1;
            [weak __fetchOrderList];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
    
}


- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.view.bounds.size.height - 49) style:UITableViewStyleGrouped];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = RGB(246, 246, 246);
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
        WeakObj(self);
        [_myTableView addRefreshHeaderWithBlock:^{
            selfWeak.currentPage = 1;
            [selfWeak __fetchOrderList];
        }];
        [_myTableView addRefreshFootWithBlock:^{
            selfWeak.currentPage +=1;
            [selfWeak __fetchOrderList];
        }];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[JYBHomeOrderListCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeOrderListCell class])];
    }
    return _myTableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
