//
//  MeViewController.m
//  Freight_Dirver
//
//  Created by cc on 2018/1/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import <YYKit.h>
#import "TrasformViewController.h"
#import "MyDriverViewController.h"
#import "UserInfoViewController.h"
#import "SonMemberViewController.h"
#import "CCWebViewViewController.h"
#import "UIButton+SSEdgeInsets.h"
#import "SystemMessageViewController.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "CPConfig.h"


@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *phone, *UserAgreeContent;
    UserModel *selfuser;
}
@property (nonatomic, retain) UITableView *noUseTableView;

@property (nonatomic, retain) NSArray *titleArr, *picArr;

@property (nonatomic, retain) UIImageView *headView;

@property (nonatomic, retain) UILabel *nickName, *companyName, *balanceLab;

@property (nonatomic, retain) UIButton *messageBtn;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.noUseTableView];
    self.navigationView.hidden = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.noUseTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.noUseTableView.scrollIndicatorInsets = self.noUseTableView.contentInset;
    
    
}

- (void)getData {
    
//     客服电话
    [HttpRequest postPath:@"/Home/Public/kfdh" params:nil resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            NSString *data = datadic[@"data"];
            phone = data;
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
//     用户注册协议
    [HttpRequest postPath:@"/Home/Public/yhxy" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            NSString *data = datadic[@"data"];
            UserAgreeContent = data;
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
// 获取用户信息
    WeakSelf(weak);
    [HttpRequest postPath:@"/Home/User/getUserInfo" params:nil resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            NSDictionary *data = datadic[@"data"];
            UserModel *user = [UserModel mj_objectWithKeyValues:data];
            selfuser = user;
            [weak.headView sd_setImageWithURL:[NSURL URLWithString:user.head_img] placeholderImage:[UIImage imageNamed:@"ddxq_icon_96  (3)"]];
            weak.nickName.text = user.user_name;
            weak.companyName.text = user.company_info.company_name;
            NSString *blanceStr = [NSString stringWithFormat:@"余额：￥%@", user.company_info.total_amount];
            [[CPConfig sharedManager] saveTotalAmount:user.company_info.total_amount];
            weak.balanceLab.text = blanceStr;
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    if (![ConfigModel getBoolObjectforKey:IsLogin]) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.homeBlocl = ^{
            self.tabBarController.selectedIndex = 0;
        };
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:na animated:YES completion:nil];
        return;
    }
    [self getData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        UILabel *line = [[UILabel alloc] initWithFrame:FRAME(0, SizeHeight(60) - 1, kScreenW, 1)];
        line.backgroundColor = RGB(239, 240, 241);
        [cell.contentView addSubview:line];
    }
    NSString *imagestr = self.picArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imagestr];
    [cell.imageView sizeToFit];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SizeHeight(60);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[SonMemberViewController new] animated:YES];
    }
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[MyDriverViewController new] animated:YES];
    }
    if (indexPath.row == 2) {
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    if (indexPath.row == 3) {
        CCWebViewViewController *vc = [[CCWebViewViewController alloc] init];
        vc.titlestr = @"用户协议";
        vc.content = UserAgreeContent;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UITableView *)noUseTableView {
    if (!_noUseTableView) {
        _noUseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 50) style:UITableViewStylePlain];
        _noUseTableView.backgroundColor = [UIColor whiteColor];
        _noUseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _noUseTableView.delegate = self;
        _noUseTableView.dataSource = self;
        _noUseTableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeHeight(206))];
            view.backgroundColor = [UIColor clearColor];
            [self addheadView:view];
            view;
        });
        _noUseTableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,  SizeHeight(60))];
            UIButton *logoutBtn = [[UIButton alloc] initWithFrame:FRAME(10, SizeHeight(10), kScreenW - 20, SizeHeight(50))];
            logoutBtn.backgroundColor = RGB(239, 240, 241);
            [logoutBtn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
            [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
            logoutBtn.layer.masksToBounds = YES;
            [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
            logoutBtn.layer.cornerRadius = SizeHeight(5);
            [view addSubview:logoutBtn];
            view;
        });
    }
    return _noUseTableView;
}

- (void)messageClick {
    [self.navigationController pushViewController:[SystemMessageViewController new] animated:YES];
}

- (void)addheadView:(UIView *)view {
    
    UIImageView *back = [[UIImageView alloc] initWithFrame:view.frame];
    back.image = [UIImage imageNamed:@"wd_bg_grzx"];
    [view addSubview:back];
    
    self.messageBtn = [[UIButton alloc] initWithFrame:FRAME(kScreenW - SizeWidth(46), SizeHeight(34), SizeWidth(30), SizeHeight(24))];
    self.messageBtn.backgroundColor = [UIColor clearColor];
    [self.messageBtn setImage:[UIImage imageNamed:@"nav_icon_xx"] forState:UIControlStateNormal];
    [self.messageBtn setBadgeValue:10];
    [self.messageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.messageBtn];
    
    self.headView = [[UIImageView alloc] initWithFrame:FRAME(SizeWidth(20), SizeHeight(68), SizeWidth(70), SizeWidth(70))];
    self.headView.backgroundColor = [UIColor clearColor];
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.cornerRadius = SizeWidth(35);
    self.headView.image = [UIImage imageNamed:@"ddxq_icon_96  (3)"];
    [view addSubview:self.headView];
    
    self.nickName = [[UILabel alloc] initWithFrame:FRAME(self.headView.right + SizeWidth(21), SizeHeight(81), kScreenW/2, SizeHeight(20))];
    self.nickName.backgroundColor = [UIColor clearColor];
    self.nickName.font = [UIFont boldSystemFontOfSize:18];
    self.nickName.text = @"你好";
    [view addSubview:self.nickName];
    
    self.companyName = [[UILabel alloc] initWithFrame:FRAME(self.headView.right + SizeWidth(21), self.nickName.bottom + SizeHeight(10), kScreenW/2, SizeHeight(20))];
    self.companyName.textColor = UIColorFromHex(0x666666);
    self.companyName.font = [UIFont systemFontOfSize:15];
    self.companyName.text = @"杭州大河外卖有限公司";
    [view addSubview:self.companyName];
    
    UIView *halfView  = [[UIView alloc] initWithFrame:FRAME(SizeWidth(10), self.headView.bottom + SizeHeight(24), kScreenW - SizeWidth(20), SizeHeight(45))];
    halfView.layer.masksToBounds = YES;
    halfView.layer.cornerRadius = 2;
    halfView.backgroundColor = RGBColorAlpha(238, 238, 238, 0.3);
    
    self.balanceLab = [[UILabel alloc] initWithFrame:FRAME(SizeWidth(10), SizeHeight(15), kScreenW/2, SizeHeight(15))];
    self.balanceLab.backgroundColor = [UIColor clearColor];
    self.balanceLab.textColor = UIColorFromHex(0xF4923E);
    self.balanceLab.font = [UIFont systemFontOfSize:13];
    self.balanceLab.text = @"余额：￥110,110,110.00";
    [halfView addSubview:self.balanceLab];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:FRAME(kScreenW - SizeWidth(20) - SizeWidth(15), SizeHeight(15), SizeWidth(10), SizeHeight(16))];
    logo.backgroundColor = [UIColor clearColor];
    logo.image = [UIImage imageNamed:@"wd_icon_gd 拷贝"];
    [halfView addSubview:logo];
    
    UILabel *textlab = [[UILabel alloc] initWithFrame:FRAME(kScreenW/2, SizeHeight(15), kScreenW/2 - SizeWidth(30) - SizeWidth(10), SizeHeight(15))];
    textlab.backgroundColor = [UIColor clearColor];
    textlab.textColor = UIColorFromHex(0xcccccc);
    textlab.textAlignment = NSTextAlignmentRight;
    textlab.font = [UIFont systemFontOfSize:13];
    textlab.text = @"查看交易记录";
    [halfView addSubview:textlab];
    [view addSubview:halfView];
    
    UIButton *headbtn = [[UIButton alloc] initWithFrame:self.headView.frame];
    headbtn.backgroundColor = [UIColor clearColor];
    headbtn.tag = 101;
    [headbtn addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:headbtn];
    
    UIButton *morebtn = [[UIButton alloc] initWithFrame:halfView.frame];
    morebtn.backgroundColor = [UIColor clearColor];
    morebtn.tag = 102;
    [morebtn addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:morebtn];
    
}

- (void)infoClick:(UIButton *)sender {
    if (sender.tag == 101) {
        UserInfoViewController *vc = [[UserInfoViewController alloc] init];
        vc.model = selfuser;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self.navigationController pushViewController:[TrasformViewController new] animated:YES];
    }
}

- (void)logout {
    [[[JYBAlertView alloc] initWithTitle:@"提示" message:@"是否退出账号" cancelItem:@"取消" sureItem:@"确认" clickAction:^(NSInteger index) {
        if (index == 1) {
            
        }
    }] show];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"子账号管理", @"我的司机", @"平台客服", @"用户协议"];
    }
    return _titleArr;
}


- (NSArray *)picArr {
    if (!_picArr) {
        _picArr = @[@"wd_icon_zzhgl", @"wd_icon_wdsj", @"wd_icon_ptkf", @"wd_icon_yhxy"];
    }
    return _picArr;
}

@end
