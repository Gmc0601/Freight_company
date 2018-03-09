//
//  JYBOrderOtherCostVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/14.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBOrderOtherCostVC.h"
#import "JYBOrderOtherCostItmeCell.h"
#import "JYBOrderOtherCostMarkCell.h"
#import "JYBOrderOtherCostImageCell.h"

@interface JYBOrderOtherCostVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@end

@implementation JYBOrderOtherCostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    
    [self.view addSubview:self.myTableView];
    
}

- (void)resetFather {
    self.titleLab.text = @"额外费用明细";
    self.rightBar.hidden = YES;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        return UITableViewAutomaticDimension;
    }else if (indexPath.row == 5){
        return SizeWidth(100);
    }else{
        return SizeWidth(45);
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        JYBOrderOtherCostMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderOtherCostMarkCell class]) forIndexPath:indexPath];
        return cell;

    }else if (indexPath.row == 5){
        JYBOrderOtherCostImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderOtherCostImageCell class]) forIndexPath:indexPath];
        return cell;
        
    }else{
        JYBOrderOtherCostItmeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderOtherCostItmeCell class]) forIndexPath:indexPath];
        return cell;
        
    }
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

        [_myTableView registerClass:[JYBOrderOtherCostItmeCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderOtherCostItmeCell class])];
        [_myTableView registerClass:[JYBOrderOtherCostMarkCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderOtherCostMarkCell class])];
        [_myTableView registerClass:[JYBOrderOtherCostImageCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderOtherCostImageCell class])];

    }
    return _myTableView;
}
@end