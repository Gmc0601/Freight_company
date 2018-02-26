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

@interface JYBHomeOtherCostVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)NSMutableArray *dataArr;


@end

@implementation JYBHomeOtherCostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
    
}

- (void)resetFather {
    self.titleLab.text = @"额外费用";
    self.rightBar.hidden = YES;
    
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
        return SizeWidth(60);
    }else{
        return SizeWidth(60);
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JYBHomeGoodWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeGoodWeightCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        JYBHomePortCostCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePortCostCell class]) forIndexPath:indexPath];
        return cell;
        
    }

}

- (void)commitBtnAction{
    
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
