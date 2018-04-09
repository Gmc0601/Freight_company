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
#import "JYBHomeQuickOrderView.h"
#import "JYBHomeImproveBoxInfoVC.h"
#import "CCWebViewViewController.h"
#import "JYBHomeSelectStationVC.h"
#import "LoginViewController.h"
#import <MJExtension.h>


//model
#import "JYBHomeBannerModel.h"
#import "JYBHomePortModel.h"
#import "JYBHomeQuickOrderPriceModel.h"
#import "JYBHomeQuickModel.h"
#import "CPConfig.h"




@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,JYBHomeSelectStationVCDelegate>

@property (nonatomic ,strong) UIView *headerView;

@property (nonatomic ,strong)SDCycleScrollView *sdCycleView;

@property (nonatomic ,strong)NSMutableArray *barnnerArr;

@property (nonatomic ,strong)NSMutableArray *portArr;

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic, strong) ESPickerView *pickerView;

@property (nonatomic ,strong)JYBHomePortModel    *selPortModel;

@property (nonatomic ,strong)JYBHomeStationSeleModel *stationModel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigation];
    
    //获取存储的port
    self.selPortModel = [[CPConfig sharedManager] lastPort];
    
    [self.view addSubview:self.myTableView];
    
    self.myTableView.tableHeaderView = self.headerView;

    //获取banner
    [self __fetchBannerData];
    //获取港口
    [self __fetchPortListData];
}

- (void)__fetchBannerData{
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Index/getBanner" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {

            for (NSDictionary *subDic in datadic[@"data"]) {
                JYBHomeBannerModel *model = [JYBHomeBannerModel modelWithDictionary:subDic];
                [weak.barnnerArr addObject:model];
            }
            [weak p_updateBannerWithModelArr:weak.barnnerArr];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}


- (void)__fetchPortListData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Public/getPortList" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            for (NSDictionary *subDic in datadic[@"data"]) {
                JYBHomePortModel *model = [JYBHomePortModel modelWithDictionary:subDic];
                [weak.portArr addObject:model];
            }
            [weak.myTableView reloadData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}





- (void)p_updateBannerWithModelArr:(NSMutableArray *)moArr{
    NSMutableArray *imageStrArr = [[NSMutableArray alloc] init];
    for (JYBHomeBannerModel *model in moArr) {
        [imageStrArr addObject:model.ad_img];
    }
    self.sdCycleView.imageURLStringsGroup = imageStrArr;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //   插 一个获取个人信息
    if (![ConfigModel getIntObjectforKey:IsLogin]) {
        return;
    }
    [HttpRequest postPath:@"/Home/User/getUserInfo" params:nil resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            NSDictionary *data = datadic[@"data"];
            UserModel *user = [UserModel mj_objectWithKeyValues:data];
            [[CPConfig sharedManager] saveTotalAmount:user.company_info.total_amount];
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
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
    JumpMessage
}

//  客服
-(void)backAction {
    
    [[[JYBAlertView alloc] initWithTitle:@"确定联系平台客服？" message:[ConfigModel getStringforKey:Servicephone] cancelItem:@"取消" sureItem:@"确认" clickAction:^(NSInteger index) {
        if (index == 1) {
            NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",[ConfigModel getStringforKey:Servicephone]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
        }
    }] show];
    
}


- (void)__commit{
    
    if (!self.selPortModel) {
        [ConfigModel mbProgressHUD:@"请选择港口" andView:nil];
        return;
    }
    
    if (!self.stationModel) {
        [ConfigModel mbProgressHUD:@"请选择装箱区域" andView:nil];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:self.stationModel.loadarea_id forKey:@"loadarea_id"];
    [dic addUnEmptyString:self.selPortModel.port_id forKey:@"prot_id"];
    
    [ConfigModel showHud:self];
    NSLog(@"~~~~para:%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Public/quickOrderList" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            JYBHomeQuickOrderPriceModel *model = [JYBHomeQuickOrderPriceModel modelWithDictionary:datadic[@"data"]];
            [weak __fetchQuickOrderlistWithModel:model];
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (void)__fetchQuickOrderlistWithModel:(JYBHomeQuickOrderPriceModel *)model{
    
    NSMutableArray *modelArr = [[NSMutableArray alloc] init];
    NSArray *nameArr = @[@"小柜拼车",@"小柜单放",@"大柜",@"高柜",@"超高柜"];
    NSArray *sepcArr = @[@"1x20GP(拼)",@"1x20GP",@"1x40GP",@"1x40HQ",@"1x45HQ"];
    NSArray *freArr = @[model.freight_list.small_carpool,model.freight_list.small_single,model.freight_list.big_cabinet,model.freight_list.tall_cabinet,model.freight_list.super_tall_cabinet];
    NSArray *cashArr = @[model.cash_list.small_carpool,model.cash_list.small_single,model.cash_list.big_cabinet,model.cash_list.tall_cabinet,model.cash_list.super_tall_cabinet];
    
    for (int i = 0; i<5; i++) {
        JYBHomeQuickModel *submodel = [[JYBHomeQuickModel alloc] init];
        submodel.name = nameArr[i];
        submodel.sepc = sepcArr[i];
        submodel.freight = freArr[i];
        submodel.cash = cashArr[i];
        [modelArr addObject:submodel];
    }
    
    WeakObj(self);
    [[[JYBHomeQuickOrderView alloc] initWithArr:modelArr clickAction:^(NSInteger index) {
        JYBHomeImproveBoxInfoVC *vc = [[JYBHomeImproveBoxInfoVC alloc] init];
        JYBHomeQuickModel *quickmodel = [modelArr objectAtIndex:index];
        vc.sepc = quickmodel.sepc;
        [selfWeak.navigationController pushViewController:vc animated:YES];
    }] show];
    
}

- (void)__pickPort{
    WeakObj(self);
    
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    for (JYBHomePortModel *model in self.portArr) {
        [titleArr addObject:model.port_name];
    }
    [self.pickerView animationShowWithItems:titleArr selectedItemComplete:^(ESPickerView *pickerView, NSString *item, NSDate *date) {
        if (item) {
            selfWeak.selPortModel = [selfWeak __selectPortWithName:item];
            [[CPConfig sharedManager] saveLastPort:selfWeak.selPortModel];
            [selfWeak.myTableView reloadData];
        }
        
        [pickerView animationDismiss];
    }];
}

- (JYBHomePortModel *)__selectPortWithName:(NSString *)name{
    
    for (JYBHomePortModel *model in self.portArr) {
        if ([model.port_name isEqualToString:name]) {
            return model;
        }
    }
    return nil;
}


- (void)selectStationModel:(JYBHomeStationSeleModel *)model{
    self.stationModel = model;
    [self.myTableView reloadData];
}


#pragma mark -
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
        [cell updateCellWithPort:self.selPortModel station:self.stationModel.loadarea_name];
        WeakObj(self);
        [cell setSelectBlock:^{
            [selfWeak __pickPort];
        }];
        
        [cell setCommitBlock:^{
            [selfWeak __commit];
        }];
        
        [cell setStationBlock:^{
            
            JYBHomeSelectStationVC *vc = [[JYBHomeSelectStationVC alloc] init];
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
            WeakSelf(weak)
            [cell setMoudleBlock:^(NSInteger index) {
                [weak __turnNextIndex:index];
            }];
            return cell;
        }else{
            JYBHomeTagCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeTagCell class]) forIndexPath:indexPath];
            return cell;
        }
    }
}

- (void)__turnNextIndex:(NSInteger)index{
    if (index == 5) {
        CCWebViewViewController *vc = [[CCWebViewViewController alloc] init];
        vc.UrlStr = @"http://www.baidu.com";
        [self.navigationController pushViewController:vc animated:YES];
        return ;
    }
    
    NSArray *sepcArr = @[@"1x20GP(拼)",@"1x20GP",@"1x40GP",@"1x40HQ",@"1x45HQ"];
    JYBHomeImproveBoxInfoVC *vc = [[JYBHomeImproveBoxInfoVC alloc] init];
    vc.sepc = [sepcArr objectAtIndex:index];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    JYBHomeBannerModel *model = [self.barnnerArr objectAtIndex:index];

    CCWebViewViewController *vc = [[CCWebViewViewController alloc] init];
    vc.UrlStr = model.ad_link;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"---点击了第%ld张图片", (long)index);
    
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

- (NSMutableArray *)portArr{
    if (_portArr == nil) {
        _portArr = [[NSMutableArray alloc] init];
    }
    return _portArr;
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
