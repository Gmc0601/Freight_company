//
//  JYBHomeFetchBoxListVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeFetchBoxListVC.h"
#import "JYBHomePackingInputCell.h"

@interface JYBHomeFetchBoxListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)UIView   *bottomView;

@end

@implementation JYBHomeFetchBoxListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];

}

- (void)resetFather {
    self.titleLab.text = @"编辑拿箱单地址";
    self.rightBar.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SizeWidth(55);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    JYBHomePackingInputCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomePackingInputCell class]) forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell updateCellWithTitle:@"拿箱单地址" placeHoler:@"请填写拿箱单地址(必填)"];
    }else if (indexPath.row == 1){
        [cell updateCellWithTitle:@"联系人" placeHoler:@"请填写联系人姓名(必填)"];
    }else{
        [cell updateCellWithTitle:@"电话" placeHoler:@"请填写联系人电话(必填)"];
    }
    
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
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        [commitBtn setTitle:@"保存" forState:UIControlStateNormal];
        [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commitBtn.layer.cornerRadius = 2;
        commitBtn.layer.masksToBounds = YES;
        [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:commitBtn];
    }
    return _bottomView;
}

@end
