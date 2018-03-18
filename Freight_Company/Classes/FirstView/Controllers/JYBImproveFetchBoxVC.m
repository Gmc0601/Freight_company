//
//  JYBImproveFetchBoxVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBImproveFetchBoxVC.h"
#import "JYBHomeFetchBoxPortCell.h"
#import "JYBHomePackingInputCell.h"
#import "JYBHomeManageFetchBoxVC.h"
#import "JYBHomePackAddressCell.h"
#import "JYBHomePackAddressListVC.h"
#import "JYBHomeImproBoxSaveCell.h"
#import "JYBHomePortModel.h"
#import "ESPickerView.h"
#import "CPHomeBoxAddressModel.h"
#import "AppDelegate.h"
@interface JYBImproveFetchBoxVC ()<UITableViewDelegate,UITableViewDataSource,JYBHomePackAddressListVCDelegate>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)NSMutableArray *dataArr;

@property (nonatomic ,strong)NSMutableArray *portArr;

@property (nonatomic ,strong)JYBHomePortModel *portModel;

@property (nonatomic ,strong)CPHomeBoxAddressModel *addressModel;

@property (nonatomic, strong) ESPickerView *pickerView;

@property (nonatomic ,assign) BOOL      isSelect;
@end

@implementation JYBImproveFetchBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];

    self.addressModel = [[CPHomeBoxAddressModel alloc] init];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];

    [self __fetchPortListData];
    [self __fetchrecentlyBoxAddress];
}


- (void)resetFather {
    self.titleLab.text = @"完善拿箱单信息";
    [self.rightBar setTitle:@"常用地址" forState:UIControlStateNormal];

}

- (void)__fetchPortListData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Public/getPortList" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            for (NSDictionary *subDic in datadic[@"data"]) {
                JYBHomePortModel *model = [JYBHomePortModel modelWithDictionary:subDic];
                [weak.portArr addObject:model];
            }
            [weak.myTableView reloadData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (void)__fetchrecentlyBoxAddress{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/User/recentlyBoxAddress" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            for (NSDictionary *subDic in datadic[@"data"]) {
                CPHomeBoxAddressModel *model = [CPHomeBoxAddressModel modelWithDictionary:subDic];
                [weak.dataArr addObject:model];
            }
            [weak.myTableView reloadData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

//  右侧点击
- (void)more:(UIButton *)sender{
    JYBHomePackAddressListVC *vc = [[JYBHomePackAddressListVC alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)selectaddressModel:(CPHomeBoxAddressModel *)addressModel{
   JYBHomePackingInputCell *ordercell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ordercell.myTextField.text = addressModel.box_address_id;
    
    JYBHomePackingInputCell *addresscell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    addresscell.myTextField.text = addressModel.box_address_desc;
    
    JYBHomePackingInputCell *namecell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    namecell.myTextField.text = addressModel.box_linkman;
    
    JYBHomePackingInputCell *phonecell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    phonecell.myTextField.text = addressModel.box_linkman_phone;
    
}

- (void)__pickPort{
    WeakObj(self);
    
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    for (JYBHomePortModel *model in self.portArr) {
        [titleArr addObject:model.port_name];
    }
    [self.pickerView animationShowWithItems:titleArr selectedItemComplete:^(ESPickerView *pickerView, NSString *item, NSDate *date) {
        if (item) {
            selfWeak.portModel = [selfWeak __selectPortWithName:item];
            [selfWeak.myTableView reloadData];
        }
        
        [pickerView animationDismiss];
    }];
}

- (JYBHomePortModel *)__selectPortWithName:(NSString *)name{
    
    for (JYBHomePortModel *model in self.portArr) {
        if ([model.port_name isEqualToString:name]) {
            return model;
        }
    }
    return nil;
}


- (void)commitBtnAction{
    
    if (!self.portModel) {
        [ConfigModel mbProgressHUD:@"请先选择港口" andView:nil];
        return;
    }
    
    JYBHomePackingInputCell *numcell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if ([NSString stringIsNilOrEmpty:numcell.myTextField.text]) {
        [ConfigModel mbProgressHUD:@"请先输入提单号" andView:nil];
        return;
    }
    
    JYBHomePackingInputCell *addresscell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    JYBHomePackingInputCell *namecell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    JYBHomePackingInputCell *phonecell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:addresscell.myTextField.text forKey:@"box_address_desc"];
    [dic addUnEmptyString:namecell.myTextField.text forKey:@"box_linkman"];
    [dic addUnEmptyString:phonecell.myTextField.text forKey:@"box_linkman_phone"];
    [dic addUnEmptyString:self.isSelect?@"1":@"0" forKey:@"is_use"];

    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/User/addEditBoxAddress" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
            
            CPHomeBoxAddressModel *addressModel = [[CPHomeBoxAddressModel alloc] init];
            addressModel.box_address_desc = addresscell.myTextField.text;
            addressModel.box_linkman = namecell.myTextField.text;
            addressModel.box_linkman_phone = phonecell.myTextField.text;
            addressModel.box_address_id = datadic[@"data"][@"box_address_id"];
            addressModel.portModel = self.portModel;
            addressModel.tiOrderNum = numcell.myTextField.text;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectBoxAddressModel:)]) {
                [self.delegate selectBoxAddressModel:addressModel];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weak.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
    
    
}


#pragma mark - uitableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else{
        return self.dataArr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SizeWidth(55);
    }else{
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return SizeWidth(65);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            JYBHomeFetchBoxPortCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeFetchBoxPortCell class]) forIndexPath:indexPath];
            cell.portLab.text = self.portModel?[NSString stringWithFormat:@"%@  ▼",self.portModel.port_name]:@"请选择  ▼";
            return cell;
        }else if (indexPath.row == 5){
            JYBHomeImproBoxSaveCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeImproBoxSaveCell class]) forIndexPath:indexPath];
            cell.seleBtn.selected = self.isSelect;
            WeakSelf(weak)
            [cell setSaveBlock:^{
                weak.isSelect = !weak.isSelect;
                [weak.myTableView reloadData];
            }];
            return cell;
        }else{
            JYBHomePackingInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePackingInputCell class]) forIndexPath:indexPath];
            if (indexPath.row == 1) {
                [cell updateCellWithTitle:@"提单号" placeHoler:@"请输入提单号（必填）" value:self.addressModel.box_address_id];
            }else if (indexPath.row == 2){
                [cell updateCellWithTitle:@"地址" placeHoler:@"请输入拿箱地址（选填）" value:self.addressModel.box_address_desc];
            }else if (indexPath.row == 3){
                [cell updateCellWithTitle:@"联系人" placeHoler:@"请输入联系人姓名（选填）" value:self.addressModel.box_linkman];
            }else{
                [cell updateCellWithTitle:@"电话" placeHoler:@"请输入联系人电话（选填）" value:self.addressModel.box_linkman_phone];
            }
            
            return cell;
        }
    }else{
        JYBHomePackAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePackAddressCell class]) forIndexPath:indexPath];
        CPHomeBoxAddressModel *addressModel = [self.dataArr objectAtIndex:indexPath.row];
        [cell updateCellWithModel:addressModel];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self __pickPort];
        }else if (indexPath.row == 5){
            
        }
    }else{
        CPHomeBoxAddressModel *addressModel = [self.dataArr objectAtIndex:indexPath.row];
        [self selectaddressModel:addressModel];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [UIView new];
    }else{
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(65))];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, SizeWidth(30), kScreenW, SizeWidth(35))];
        titleLab.font = [UIFont systemFontOfSize:SizeWidth(15)];
        titleLab.text = @"--------  最近拿箱单地址  --------";
        titleLab.textColor = RGB(162, 162, 162);
        titleLab.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:titleLab];
        return backView;
    }
}


- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - SizeWidth(50)) style:UITableViewStyleGrouped];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.estimatedRowHeight = 100;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[JYBHomeFetchBoxPortCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeFetchBoxPortCell class])];
        [_myTableView registerClass:[JYBHomeImproBoxSaveCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeImproBoxSaveCell class])];
        [_myTableView registerClass:[JYBHomePackingInputCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomePackingInputCell class])];
        [_myTableView registerClass:[JYBHomePackAddressCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomePackAddressCell class])];
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



- (NSMutableArray *)portArr{
    if (!_portArr) {
        _portArr = [[NSMutableArray alloc] init];
    }
    return _portArr;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
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
