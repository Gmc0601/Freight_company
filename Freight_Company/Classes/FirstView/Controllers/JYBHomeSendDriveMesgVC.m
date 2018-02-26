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

@interface JYBHomeSendDriveMesgVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)JYBHomeSendDriveHeaderView     *headerView;

@property (nonatomic ,strong)UIView   *bottomView;

@property (nonatomic ,strong)NSMutableArray *dataArr;


@end

@implementation JYBHomeSendDriveMesgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.bottomView];

}

- (void)resetFather {
    self.titleLab.text = @"给司机捎句话";
    self.rightBar.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SizeWidth(55);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(55))];
    headLab.textColor = RGB(204, 204, 204);
    headLab.font = [UIFont systemFontOfSize:SizeWidth(12)];
    headLab.textAlignment = NSTextAlignmentCenter;
    headLab.text = @"------    最近留言记录    ------";
    return headLab;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JYBHomeHasDriveMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeHasDriveMsgCell class]) forIndexPath:indexPath];
    
    cell.contentLab.text = @"斯捷克洛夫就是看了几分快s是粉丝疯狂‘说服力；看 三分乐健康科技克赖斯基弗兰克";
    
    return cell;
    
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
        [_myTableView registerClass:[JYBHomeHasDriveMsgCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeHasDriveMsgCell class])];
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
