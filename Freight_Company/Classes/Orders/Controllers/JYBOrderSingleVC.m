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

@interface JYBOrderSingleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@end

@implementation JYBOrderSingleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
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
    WeakObj(self);
    [cell setListBlock:^(JYBHomeOrderListAction action) {
        if (action == JYBHomeOrderListActionContact) {
            
        }else if (action == JYBHomeOrderListActionOrder){
            
        }else{
            [selfWeak __pay];
        }
    }];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYBOrderDetailVC *vc = [[JYBOrderDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)__pay{
    WeakObj(self);
    [[[JYBOrderPayPopView alloc] initWithClickAction:^{
        
    }] show];
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
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[JYBHomeOrderListCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeOrderListCell class])];
    }
    return _myTableView;
}
@end
