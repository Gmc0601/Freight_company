//
//  JYBHomeOtherCostVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeOtherCostVC.h"
#import "JYBHomeGoodWeightCell.h"
#import "JYBHomePortCostCell.h"
#import "JYBHomeDockWeightModel.h"
#import "JYBHomeDotModel.h"

@interface JYBHomeOtherCostVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)NSMutableArray *dataArr;

@property (nonatomic ,strong)NSMutableArray *dotArr;


@end

@implementation JYBHomeOtherCostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
    
    [self __fetchData];
}

- (void)resetFather {
    self.titleLab.text = @"额外费用";
    self.rightBar.hidden = YES;
    
}

- (void)__fetchData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:self.prot_id forKey:@"port_id"];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Public/getDockWeightPrice" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            for (NSDictionary *subDic in datadic[@"data"]) {
                JYBHomeDockWeightModel *model = [JYBHomeDockWeightModel modelWithDictionary:subDic];
                [weak.dataArr addObject:model];
            }
            [weak.myTableView reloadData];
            
            [weak __fetchDotData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
}

- (void)__fetchDotData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:self.prot_id forKey:@"port_id"];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Public/getDock" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            for (NSDictionary *subDic in datadic[@"data"]) {
                JYBHomeDotModel *model = [JYBHomeDotModel modelWithDictionary:subDic];
                [weak.dotArr addObject:model];
            }
            [weak.myTableView reloadData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SizeWidth(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SizeWidth(20);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bottView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(20))];
    bottView.backgroundColor = [UIColor whiteColor];
    return bottView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(40))];
    headLab.textColor = RGB(52, 52, 52);
    headLab.font = [UIFont systemFontOfSize:SizeWidth(14)];
    if (section == 0) {
        headLab.text = @"   货重";
    }else{
        headLab.text = @"   码头";
    }
    return headLab;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return (self.dataArr.count/4 +((self.dataArr.count%4 == 0)?0:1))*SizeWidth(75);
            
    }else{
        return (self.dotArr.count/2 +((self.dotArr.count%2 == 0)?0:1))*SizeWidth(75);
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JYBHomeGoodWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeGoodWeightCell class]) forIndexPath:indexPath];
        [cell updateCellWithArr:self.dataArr];
        WeakSelf(weak)
        [cell setWeightBlock:^(JYBHomeDockWeightModel *model) {
            [weak __refreshWightArrWithModel:model];
        }];
        return cell;
    }else{
        JYBHomePortCostCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePortCostCell class]) forIndexPath:indexPath];
        [cell updateCellWithArr:self.dotArr];
        WeakSelf(weak)
        [cell setPortBlock:^(JYBHomeDotModel *model) {
            [weak __refreshDotArrWithModel:model];
        }];
        return cell;
        
    }

}

- (void)__refreshWightArrWithModel:(JYBHomeDockWeightModel *)model{
    for (JYBHomeDockWeightModel *subModel in self.dataArr) {
        if ([subModel.weight_id isEqualToString:model.weight_id]) {
            subModel.select = YES;
        }else{
            subModel.select = NO;
        }
    }
    [self.myTableView reloadData];
}

- (void)__refreshDotArrWithModel:(JYBHomeDotModel *)model{
    for (JYBHomeDotModel *subModel in self.dotArr) {
        if ([subModel.dock_id isEqualToString:model.dock_id]) {
            subModel.select = YES;
        }else{
            subModel.select = NO;
        }
    }
    [self.myTableView reloadData];
}


- (void)commitBtnAction{
    
    JYBHomeDockWeightModel *weightModel;
    for (JYBHomeDockWeightModel *subModel in self.dataArr) {
        if (subModel.select) {
            weightModel = subModel;
        }
    }
    
    JYBHomeDotModel *dotModel;
    for (JYBHomeDotModel *subModel in self.dotArr) {
        if (subModel.select) {
            dotModel = subModel;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectWeightModel:dotModel:)]) {
        [self.delegate selectWeightModel:weightModel dotModel:dotModel];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
        _myTableView.estimatedRowHeight = 100;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[JYBHomeGoodWeightCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeGoodWeightCell class])];
        [_myTableView registerClass:[JYBHomePortCostCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomePortCostCell class])];

    }
    return _myTableView;
}


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableArray *)dotArr{
    if (!_dotArr) {
        _dotArr = [[NSMutableArray alloc] init];
    }
    return _dotArr;
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
