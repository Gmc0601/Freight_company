//
//  FirstViewController.m
//  Freight_Dirver
//
//  Created by cc on 2018/1/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "FirstViewController.h"
#import "SDCycleScrollView.h"
#import "JYBHomeModuleCell.h"
#import "JYBHomeTitleCell.h"
#import "JYBHomeTagCell.h"
#import "JYBPortSelectCell.h"
#import "ESPickerView.h"
#import "AppDelegate.h"
#import "JYBHomeEditPacktingListVC.h"
#import "JYBHomeQuickOrderView.h"
#import "JYBHomeImproveBoxInfoVC.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,JYBHomeEditPacktingDelegate>

@property (nonatomic ,strong) UIView *headerView;

@property (nonatomic ,strong)SDCycleScrollView *sdCycleView;

@property (nonatomic ,strong)NSMutableArray *barnnerArr;

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic, strong) ESPickerView *pickerView;

@property (nonatomic ,strong)NSString       *selPortStr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    self.selPortStr = @"宁波港";
    
    [self navigation];
    
    [self.view addSubview:self.myTableView];
    
    self.myTableView.tableHeaderView = self.headerView;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)navigation {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"nav_icon_kf"] action:@selector(backAction)];
    [self addRightBarButtonWithFirstImage:[UIImage imageNamed:@"nav_icon_xx"] action:@selector(message)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 20)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:view.frame];
    img.image = [UIImage imageNamed:@"icon_jyb"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:img];
    self.navigationItem.titleView = view;
}


- (void)message {
    
}

//  客服
-(void)backAction {
    
    [[[JYBAlertView alloc] initWithTitle:@"确定联系平台客服？" message:@"400-9999-0000" cancelItem:@"取消" sureItem:@"确认" clickAction:^(NSInteger index) {
        if (index == 1) {
            NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",@"400-9999-0000"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
        }
    }] show];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SizeWidth(70);
    }else{
        if (indexPath.row == 0) {
            return SizeWidth(50);
        }else if (indexPath.row == 1){
            return SizeWidth(249);
        }else{
            return SizeWidth(50);
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JYBPortSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBPortSelectCell class]) forIndexPath:indexPath];
        [cell updateCellWithPort:self.selPortStr station:nil];
        WeakObj(self);
        [cell setSelectBlock:^{
            [selfWeak __pickPort];
        }];
        
        [cell setCommitBlock:^{
            [selfWeak __commit];
        }];
        
        [cell setStationBlock:^{
            JYBHomeEditPacktingListVC *vc = [[JYBHomeEditPacktingListVC alloc] init];
            vc.delegate = self;
            [selfWeak.navigationController pushViewController:vc animated:YES];            
        }];
        
        
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            JYBHomeTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeTitleCell class]) forIndexPath:indexPath];
            return cell;
        }else if (indexPath.row == 1){
            JYBHomeModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeModuleCell class]) forIndexPath:indexPath];
            return cell;
        }else{
            JYBHomeTagCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeTagCell class]) forIndexPath:indexPath];
            return cell;
        }
    }
}

- (void)__commit{
    WeakObj(self);
    [[[JYBHomeQuickOrderView alloc] initWithArr:nil clickAction:^(NSInteger index) {
        JYBHomeImproveBoxInfoVC *vc = [[JYBHomeImproveBoxInfoVC alloc] init];
        [selfWeak.navigationController pushViewController:vc animated:YES];
    }] show];
}

- (void)__pickPort{
    WeakObj(self);
    [self.pickerView animationShowWithItems:@[@"宁波港",@"上海港"] selectedItemComplete:^(ESPickerView *pickerView, NSString *item, NSDate *date) {
        selfWeak.selPortStr = item;
        [selfWeak.myTableView reloadData];
        [pickerView animationDismiss];
    }];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}

#pragma mark - JYBHomeEditPacktingDelegate
- (void)portPackStationSel:(NSString *)packStation{
    
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenH ,SizeWidth(140))];
        _headerView.backgroundColor = [UIColor whiteColor];
        // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
        self.sdCycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(SizeWidth(10), SizeWidth(10), kScreenW - SizeWidth(20),SizeWidth(130))];
        self.sdCycleView .placeholderImage = [UIImage imageNamed:@"placeholder"];
        self.sdCycleView.backgroundColor = RGB(245, 245, 245);
        self.sdCycleView.currentPageDotImage = [UIImage imageNamed:@""];
        self.sdCycleView.pageDotImage =  [UIImage imageNamed:@""];
        self.sdCycleView.delegate = self;
        [_headerView addSubview:self.sdCycleView];
    }
    return _headerView;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = RGB(245, 245, 245);
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
        [_myTableView registerClass:[JYBPortSelectCell class] forCellReuseIdentifier:NSStringFromClass([JYBPortSelectCell class])];
        [_myTableView registerClass:[JYBHomeModuleCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeModuleCell class])];
        [_myTableView registerClass:[JYBHomeTitleCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeTitleCell class])];
        [_myTableView registerClass:[JYBHomeTagCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeTagCell class])];
    }
    return _myTableView;
}

- (NSMutableArray *)barnnerArr{
    if (_barnnerArr == nil) {
        _barnnerArr = [[NSMutableArray alloc] init];
    }
    return _barnnerArr;
}

- (ESPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[ESPickerView alloc] init];
        _pickerView.hidden = YES;
        AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow *keyWindow =appDelegate.window;
        [keyWindow addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(keyWindow);
        }];
        [keyWindow layoutIfNeeded];
    }
    return _pickerView;
}

@end
