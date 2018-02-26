//
//  JYBOrderLogisInfoVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/14.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBOrderLogisInfoVC.h"
#import "JYBHomeOrderLogisItemCell.h"

@interface JYBOrderLogisInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;


@end

@implementation JYBOrderLogisInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    
    [self.view addSubview:self.myTableView];
    
}

- (void)resetFather {
    self.titleLab.text = @"物流信息";
    self.rightBar.hidden = YES;
    
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
    
    return UITableViewAutomaticDimension;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYBHomeOrderLogisItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeOrderLogisItemCell class]) forIndexPath:indexPath];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}


- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 ) style:UITableViewStylePlain];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = RGB(246, 246, 246);
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
        [_myTableView registerClass:[JYBHomeOrderLogisItemCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeOrderLogisItemCell class])];
    }
    return _myTableView;
}
@end
