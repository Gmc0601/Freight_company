//
//  JYBHomeEditPacktingListVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeEditPacktingListVC.h"
#import "JYBHomePackingSelCell.h"
#import "JYBHomePackingInputCell.h"
#import "JYBHomeSelectStationVC.h"
#import "JYBHomeShipAddressModel.h"
#import "JYBHomePackAddressListVC.h"

@interface JYBHomeEditPacktingListVC ()<UITableViewDelegate,UITableViewDataSource,JYBHomeSelectStationVCDelegate,JYBHomePackAddressListVCDelegate>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)NSString *packArea;

@property (nonatomic ,strong)NSString *packStation;

@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)JYBHomeStationSeleModel *stationModel;

@property (nonatomic ,strong)AMapTip *pointModel;

@property (nonatomic ,strong)NSString *provice;

@property (nonatomic ,strong)NSString *city;

@end

@implementation JYBHomeEditPacktingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
}

- (void)resetFather {
    
    self.titleLab.text = @"编辑装箱点";
    self.rightBar.hidden = YES;
//    [self.rightBar setTitle:@"常用地址" forState:UIControlStateNormal];

}

////  右侧点击
//- (void)more:(UIButton *)sender{
//    JYBHomePackAddressListVC *vc = [[JYBHomePackAddressListVC alloc] init];
//    vc.delegate = self;
//    vc.isPoint = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//
//}

//- (void)selectPointModel:(JYBHomeShipAddressModel *)pointModel{
//
//    if (self.delegate && [self.delegate respondsToSelector:@selector(portPackStationSel:)]) {
//        [self.delegate portPackStationSel:pointModel];
//    }
//
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.shipAddressModel) {
        [self initSetUpWithModel:self.shipAddressModel];
    }
}


- (void)initSetUpWithModel:(JYBHomeShipAddressModel *)model{
    
    JYBHomeStationSeleModel *stationModel = [[JYBHomeStationSeleModel alloc] init];
    stationModel.loadarea_id = model.loadarea_id;
    stationModel.loadarea_name = model.loadarea_name;
    self.stationModel = stationModel;
    
    AMapTip *amapModel = [[AMapTip alloc] init];
    amapModel.name = model.address;
    amapModel.location.latitude = model.lat.floatValue;
    amapModel.location.longitude = model.lon.floatValue;
    self.pointModel = amapModel;
    
    JYBHomePackingInputCell *addressCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    addressCell.myTextField.text = model.address_desc;
    
    JYBHomePackingInputCell *nameCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    nameCell.myTextField.text = model.shipment_linkman;

    JYBHomePackingInputCell *phoneCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    phoneCell.myTextField.text = model.shipment_linkman_phone;

    [self.myTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return SizeWidth(55);

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 2) {
        JYBHomePackingSelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePackingSelCell class]) forIndexPath:indexPath];
        [cell updateCellWithTitle:(indexPath.row == 0?@"装箱区域":@"装箱地点") result:(indexPath.row == 0?self.stationModel.loadarea_name:self.pointModel.name) indexPath:indexPath];
        WeakObj(self);
        [cell setSelBlock:^(NSIndexPath *selIndexPath) {
            [selfWeak __pickPack:selIndexPath];
        }];
        return cell;
    }else{
        JYBHomePackingInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePackingInputCell class]) forIndexPath:indexPath];
        if (indexPath.row == 2) {
            [cell updateCellWithTitle:@"详细地址" placeHoler:@"街道、门牌号" value:nil];
        }else if (indexPath.row == 3){
            [cell updateCellWithTitle:@"联系人" placeHoler:@"请填写装箱联系人" value:nil];
        }else{
            [cell updateCellWithTitle:@"电话" placeHoler:@"请填写装箱联系人电话" value:nil];
        }
        
        return cell;
    }
    
}

- (void)__pickPack:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1 && !self.stationModel) {
        [ConfigModel mbProgressHUD:@"请先选择装箱区域" andView:nil];
        return;
    }
    
    JYBHomeSelectStationVC *vc = [[JYBHomeSelectStationVC alloc] init];
    vc.delegate = self;
    vc.isPoint = (indexPath.row == 1);
    vc.city = self.stationModel.city;
    vc.keyWords = self.stationModel.loadarea_name;
    [self.navigationController pushViewController:vc animated:YES];
  
}

- (void)selectStationModel:(JYBHomeStationSeleModel *)model{
    self.stationModel = model;
    [self.myTableView reloadData];
}

- (void)selectPoint:(AMapTip *)point{
    self.pointModel = point;
    [self.myTableView reloadData];
}

- (void)commitBtnAction{
    
    if (!self.stationModel) {
        [ConfigModel mbProgressHUD:@"请选择装箱区域" andView:nil];
    }
    
    if (!self.pointModel) {
        [ConfigModel mbProgressHUD:@"请选择装箱地点" andView:nil];
    }
    
    JYBHomePackingInputCell *addresCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    JYBHomePackingInputCell *nameCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    JYBHomePackingInputCell *phoneCell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:self.shipAddressModel.shipment_address_id forKey:@"shipment_address_id"];
    [dic addUnEmptyString:[NSString stringWithFormat:@"%lf",self.pointModel.location.longitude] forKey:@"long"];
    [dic addUnEmptyString:[NSString stringWithFormat:@"%lf",self.pointModel.location.latitude] forKey:@"lat"];
    [dic addUnEmptyString:self.pointModel.name forKey:@"address"];
    [dic addUnEmptyString:addresCell.myTextField.text forKey:@"address_desc"];
    [dic addUnEmptyString:nameCell.myTextField.text forKey:@"shipment_linkman"];
    [dic addUnEmptyString:phoneCell.myTextField.text forKey:@"shipment_linkman_phone"];
    [dic addUnEmptyString:self.stationModel.loadarea_id forKey:@"loadarea_id"];
    [dic addUnEmptyString:self.stationModel.province forKey:@"province"];
    [dic addUnEmptyString:self.stationModel.city forKey:@"city"];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/User/addEditShipAddress" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
//            
//            JYBHomeShipAddressModel * model = [[JYBHomeShipAddressModel alloc] init];
//            model.shipment_address_id = datadic[@"data"][@"shipment_address_id"];
//            model.province = weak.provice;
//            model.city = weak.city;
//            model.address = addresCell.myTextField.text;
//            model.shipment_linkman = nameCell.myTextField.text;
//            model.shipment_linkman_phone = phoneCell.myTextField.text;
//            
//            if (self.delegate && [self.delegate respondsToSelector:@selector(portPackStationSel:)]) {
//                [self.delegate portPackStationSel:model];
//            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
    

}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - SizeWidth(50)) style:UITableViewStylePlain];
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
        [_myTableView registerClass:[JYBHomePackingSelCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomePackingSelCell class])];
        [_myTableView registerClass:[JYBHomePackingInputCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomePackingInputCell class])];
    }
    return _myTableView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - SizeWidth(50) , kScreenW, SizeWidth(50))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(10), SizeWidth(5), kScreenW - SizeWidth(20), SizeWidth(40))];
        commitBtn.backgroundColor = RGB(24, 141, 240);
        [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commitBtn.layer.cornerRadius = 2;
        commitBtn.layer.masksToBounds = YES;
        [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:commitBtn];
    }
    return _bottomView;
}


@end
