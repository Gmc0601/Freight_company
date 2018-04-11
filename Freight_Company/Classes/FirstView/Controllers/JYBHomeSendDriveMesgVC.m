//
//  JYBHomeSendDriveMesgVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSendDriveMesgVC.h"
#import "JYBHomeHasDriveMsgCell.h"
#import "JYBHomeSendDriveHeaderView.h"
#import "JYBHomeDockWeightModel.h"
#import "JYBHomeGoodWeightCell.h"

@interface JYBHomeSendDriveMesgVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)JYBHomeSendDriveHeaderView     *headerView;

//@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)NSMutableArray *dataArr;

@property (nonatomic ,strong)NSMutableArray *dotArr;

@end

@implementation JYBHomeSendDriveMesgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headerView;
//    [self.view addSubview:self.bottomView];

    [self __fetchData];
}

- (void)resetFather {
    self.titleLab.text = @"给司机捎句话";
    self.rightBar.hidden = YES;
}


- (void)__fetchData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/User/recentlyMessageList" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            for (NSString *sub in datadic[@"data"]) {
                [weak.dataArr addObject:sub];
            }
            [weak.myTableView reloadData];
            [weak __fetchDoctWeightPriceData];
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
            [weak __fetchDoctWeightPriceData];
        }
    }];
}


- (void)__fetchDoctWeightPriceData{
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return SizeWidth(55);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return SizeWidth(70);
    }else{
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [UIView new];
    }else{
        UILabel *headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(55))];
        headLab.textColor = RGB(204, 204, 204);
        headLab.font = [UIFont systemFontOfSize:SizeWidth(12)];
        headLab.textAlignment = NSTextAlignmentCenter;
        headLab.text = @"------    最近留言记录    ------";
        return headLab;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {

        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - SizeWidth(50) , kScreenW, SizeWidth(70))];
        bottomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(10), SizeWidth(10), kScreenW - SizeWidth(20), SizeWidth(45))];
        commitBtn.backgroundColor = RGB(24, 141, 240);
        commitBtn.layer.cornerRadius = 4;
        commitBtn.layer.masksToBounds = YES;
        [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:commitBtn];
        return bottomView;

    }else{
        return [UIView new];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return (self.dotArr.count/5 +((self.dotArr.count%5 == 0)?0:1))*SizeWidth(56);
    }else{
        return UITableViewAutomaticDimension;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JYBHomeGoodWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeGoodWeightCell class]) forIndexPath:indexPath];
        [cell updateCellWithArr:self.dotArr];
        WeakSelf(weak)
        [cell setWeightBlock:^(JYBHomeDockWeightModel *model) {
            weak.headerView.inputTextView.text = [weak.headerView.inputTextView.text stringByAppendingString:model.weight_desc];            
        }];
        return cell;
    }else{
        JYBHomeHasDriveMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeHasDriveMsgCell class]) forIndexPath:indexPath];
        
        cell.contentLab.text = [self.dataArr objectAtIndex:indexPath.row];
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else{
        NSString *mes = [self.dataArr objectAtIndex:indexPath.row];
        self.headerView.inputTextView.text = [self.headerView.inputTextView.text stringByAppendingString:mes];
    }
}

- (void)commitBtnAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectDriveMessage:)]) {
        [self.delegate selectDriveMessage:self.headerView.inputTextView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStyleGrouped];
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
        [_myTableView registerClass:[JYBHomeHasDriveMsgCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeHasDriveMsgCell class])];
        [_myTableView registerClass:[JYBHomeGoodWeightCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeGoodWeightCell class])];

        
    }
    return _myTableView;
}

- (JYBHomeSendDriveHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[JYBHomeSendDriveHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(150))];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
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

//- (UIView *)bottomView{
//    if (!_bottomView) {
//        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - SizeWidth(50) , kScreenW, SizeWidth(50))];
//        _bottomView.backgroundColor = [UIColor whiteColor];
//
//        UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SizeWidth(10), SizeWidth(5), kScreenW - SizeWidth(20), SizeWidth(40))];
//        commitBtn.backgroundColor = RGB(24, 141, 240);
//        [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
//        [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        commitBtn.layer.cornerRadius = 2;
//        commitBtn.layer.masksToBounds = YES;
//        [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView addSubview:commitBtn];
//    }
//    return _bottomView;
//}
@end
