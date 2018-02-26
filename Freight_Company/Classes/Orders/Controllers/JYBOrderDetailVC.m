//
//  JYBOrderDetailVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBOrderDetailVC.h"
#import "JYBOrderDetailLogisUserCell.h"
#import "JYBOrderDetailLogisInfoCell.h"
#import "JYBOrderDetailAddressCell.h"
#import "JYBOrderDetailBoxInfoCell.h"
#import "JYBOrderDetailMarkInfoCell.h"
#import "JYBOrderDetailCostCell.h"
#import "JYBOrderLogisInfoVC.h"
#import "JYBOrderOtherCostVC.h"


typedef enum : NSUInteger {
    JYBOrderDetailTypeLogisUser,
    JYBOrderDetailTypeLogisInfo,
    JYBOrderDetailTypeAddressInfo,
    JYBOrderDetailTypeBoxInfo,
    JYBOrderDetailTypeMarkInfo,
    JYBOrderDetailTypeCostInfo,
} JYBOrderDetailType;

@interface JYBOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)UIView   *bottomView;

@end

@implementation JYBOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
}

- (void)resetFather {
    
    
    self.titleLab.text = @"选择我的司机";
    [self.rightBar setImage:[UIImage imageNamed:@"nav_icon_dh"] forState:UIControlStateNormal];
    [self.rightBar setTitle:@"客服" forState:UIControlStateNormal];
}

- (void)more:(UIButton *)sender{
    [[[JYBAlertView alloc] initWithTitle:@"确定联系平台客服？" message:@"400-9999-0000" cancelItem:@"取消" sureItem:@"确认" clickAction:^(NSInteger index) {
        if (index == 1) {
            NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",@"400-9999-0000"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
        }
    }] show];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == JYBOrderDetailTypeLogisUser) {
        return 1;
    }else if (section == JYBOrderDetailTypeLogisInfo){
        return 2;
    }else if (section == JYBOrderDetailTypeAddressInfo){
        return 3;
    }else if (section == JYBOrderDetailTypeBoxInfo){
        return 6;
    }else if (section == JYBOrderDetailTypeMarkInfo){
        return 1;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section == JYBOrderDetailTypeLogisUser) {
        return SizeWidth(85);
    }else if (indexPath.section == JYBOrderDetailTypeLogisInfo){
        return SizeWidth(90);
    }else if (indexPath.section == JYBOrderDetailTypeAddressInfo){
        return SizeWidth(110);
    }else if (indexPath.section == JYBOrderDetailTypeBoxInfo){
        return SizeWidth(55);
    }else if (indexPath.section == JYBOrderDetailTypeMarkInfo){
        return UITableViewAutomaticDimension;
    }else{
        if (indexPath.row == 0) {
            return SizeWidth(50);
        }else{
            return SizeWidth(65);
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SizeWidth(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == JYBOrderDetailTypeLogisUser) {

        JYBOrderDetailLogisUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderDetailLogisUserCell class]) forIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == JYBOrderDetailTypeLogisInfo){

        JYBOrderDetailLogisInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderDetailLogisInfoCell class]) forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == JYBOrderDetailTypeAddressInfo){
        JYBOrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderDetailAddressCell class]) forIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == JYBOrderDetailTypeBoxInfo){
        JYBOrderDetailBoxInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderDetailBoxInfoCell class]) forIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == JYBOrderDetailTypeMarkInfo){
        JYBOrderDetailMarkInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderDetailMarkInfoCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        if (indexPath.row == 0) {
            JYBOrderDetailBoxInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderDetailBoxInfoCell class]) forIndexPath:indexPath];
            return cell;
        }else{
            JYBOrderDetailCostCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBOrderDetailCostCell class]) forIndexPath:indexPath];
            return cell;
        }

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == JYBOrderDetailTypeLogisUser) {

    }else if (indexPath.section == JYBOrderDetailTypeLogisInfo){
        JYBOrderLogisInfoVC *vc = [[JYBOrderLogisInfoVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == JYBOrderDetailTypeAddressInfo){

    }else if (indexPath.section == JYBOrderDetailTypeBoxInfo){

    }else if (indexPath.section == JYBOrderDetailTypeMarkInfo){

    }else{
         JYBOrderOtherCostVC *vc = [[JYBOrderOtherCostVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    

}


- (void)commitBtnAction{
    
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - SizeWidth(50)) style:UITableViewStyleGrouped];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = RGB(240, 240, 240);
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
        
        [_myTableView registerClass:[JYBOrderDetailLogisUserCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderDetailLogisUserCell class])];
        [_myTableView registerClass:[JYBOrderDetailLogisInfoCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderDetailLogisInfoCell class])];
        [_myTableView registerClass:[JYBOrderDetailAddressCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderDetailAddressCell class])];
        [_myTableView registerClass:[JYBOrderDetailBoxInfoCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderDetailBoxInfoCell class])];
        [_myTableView registerClass:[JYBOrderDetailMarkInfoCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderDetailMarkInfoCell class])];
        [_myTableView registerClass:[JYBOrderDetailCostCell class] forCellReuseIdentifier:NSStringFromClass([JYBOrderDetailCostCell class])];

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

@end
