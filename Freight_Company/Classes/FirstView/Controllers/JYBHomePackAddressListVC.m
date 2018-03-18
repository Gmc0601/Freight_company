//
//  JYBHomePackAddressListVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomePackAddressListVC.h"
#import "JYBHomePackAddressCell.h"
#import "JYBHomePackAddressSectionFooterView.h"
#import "JYBHomeFetchBoxListVC.h"

@interface JYBHomePackAddressListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation JYBHomePackAddressListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self __fetchData];
}

- (void)resetFather {
    self.titleLab.text = @"管理拿箱单地址";
    self.rightBar.hidden = YES;
    
}

- (void)__deleteWithModel:(CPHomeBoxAddressModel *)model{
    WeakSelf(weak)
    [[[JYBAlertView alloc] initWithTitle:@"确定删除该地址吗？" message:nil cancelItem:@"取消" sureItem:@"确认" clickAction:^(NSInteger index) {
        if (index == 1) {
            [weak __fetchDeleteDataModel:model];
        }
    }] show];
 
}

- (void)__fetchDeleteDataModel:(CPHomeBoxAddressModel *)model{
    
    [self.dataArr removeAllObjects];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:model.box_address_id forKey:@"box_address_id"];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/User/delBoxAddress" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
            [weak __fetchData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (void)__editWithModel:(CPHomeBoxAddressModel *)model{
    JYBHomeFetchBoxListVC *vc = [[JYBHomeFetchBoxListVC alloc] init];
    vc.addressModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)__fetchData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/User/getBoxAddress" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            [weak.dataArr removeAllObjects];
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


- (void)commitBtnAction{
    JYBHomeFetchBoxListVC *vc = [[JYBHomeFetchBoxListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYBHomePackAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePackAddressCell class]) forIndexPath:indexPath];
    CPHomeBoxAddressModel *model = [self.dataArr objectAtIndex:indexPath.section];
    [cell updateCellWithModel:model];
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    JYBHomePackAddressSectionFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JYBHomePackAddressSectionFooterView class])];
    CPHomeBoxAddressModel *model = [self.dataArr objectAtIndex:section];
    footer.addressModel = model;
    WeakSelf(weak)
    [footer setDeleBlock:^(CPHomeBoxAddressModel *addressModel) {
        [weak __deleteWithModel:addressModel];
    }];
    
    [footer setEditBlock:^(CPHomeBoxAddressModel *addressModel) {
        [weak __editWithModel:addressModel];
    }];
    
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CPHomeBoxAddressModel *model = [self.dataArr objectAtIndex:indexPath.section];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectaddressModel:)]) {
        [self.delegate selectaddressModel:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SizeWidth(40);
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
        [_myTableView registerClass:[JYBHomePackAddressCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomePackAddressCell class])];
        [_myTableView registerClass:[JYBHomePackAddressSectionFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JYBHomePackAddressSectionFooterView class])];
    }
    return _myTableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - SizeWidth(50) , kScreenW, SizeWidth(50))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(10), SizeWidth(5), kScreenW - SizeWidth(20), SizeWidth(40))];
        commitBtn.backgroundColor = RGB(24, 141, 240);
        [commitBtn setTitle:@"+ 添加拿箱单地址" forState:UIControlStateNormal];
        [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commitBtn.layer.cornerRadius = 2;
        commitBtn.layer.masksToBounds = YES;
        [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:commitBtn];
    }
    return _bottomView;
}

@end
