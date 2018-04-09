//
//  SonMemberViewController.m
//  Freight_Company
//
//  Created by cc on 2018/1/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "SonMemberViewController.h"
#import "SonMemberTableViewCell.h"
#import "ChangeSonMemberViewController.h"
#import <MJExtension.h>

@implementation SonmemberModel
@end

@interface SonMemberViewController ()<UITableViewDelegate,  UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, retain) UITableView *noUseTableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, retain) UIButton *addBtn;

@end

@implementation SonMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.noUseTableView];
    [self.view addSubview:self.addBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData {
    [ConfigModel showHud:self];
    WeakSelf(weak);
    [self.dataArr removeAllObjects];
    
    [HttpRequest postPath:@"/Home/User/companyUser" params:nil resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@">>>>>%@<<<<<<", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            NSDictionary *data = datadic[@"data"];
            
            self.dataArr = [SonmemberModel mj_objectArrayWithKeyValuesArray:data];
            [self.noUseTableView reloadData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}

- (void)resetFather {
    self.titleLab.text = @"子账号管理";
    self.rightBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = [NSString stringWithFormat:@"%d", indexPath.row];
    SonMemberTableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SonMemberTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    WeakSelf(weak);
    [cell update:self.dataArr[indexPath.row]];
    cell.changeBlock = ^{
        ChangeSonMemberViewController *son = [[ChangeSonMemberViewController alloc] init];
        son.type =  ChangeInfo;
        SonmemberModel *model = self.dataArr[indexPath.row];
        son.model = model;
        [weak.navigationController pushViewController:son animated:YES];
    };
    SonmemberModel *model = self.dataArr[indexPath.row];
    cell.delBlock = ^{
        [[[JYBAlertView alloc] initWithTitle:@"提示" message:@"是否删除子账号" cancelItem:@"取消" sureItem:@"确认" clickAction:^(NSInteger index) {
            if (index == 1) {
                
                NSDictionary *dic = @{
                                      @"company_user_id" : model.company_user_id
                                      };
                [HttpRequest postPath:@"/Home/User/delUser" params:dic resultBlock:^(id responseObject, NSError *error) {
                    if([error isEqual:[NSNull null]] || error == nil){
                        NSLog(@"success");
                    }
                    NSDictionary *datadic = responseObject;
                    if ([datadic[@"success"] intValue] == 1) {
                        [ConfigModel mbProgressHUD:@"操作成功" andView:nil];
                    }else {
                        NSString *str = datadic[@"msg"];
                        [ConfigModel mbProgressHUD:str andView:nil];
                    }
                }];
                
            }
        }] show];
        
    };
    
    return cell;
    
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SizeHeight(74);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (UITableView *)noUseTableView {
    if (!_noUseTableView) {
        _noUseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
        _noUseTableView.backgroundColor = [UIColor whiteColor];
        _noUseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _noUseTableView.delegate = self;
        _noUseTableView.dataSource = self;
        _noUseTableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeHeight(0))];
            view;
        });
        _noUseTableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,  SizeHeight(0))];
            view;
        });
    }
    return _noUseTableView;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:FRAME(SizeWidth(10), kScreenH - SizeHeight(50), kScreenW - SizeWidth(20), SizeHeight(40))];
        _addBtn.backgroundColor = UIColorFromHex(0x018BF2);
        [_addBtn setTitle:@"+ 添加子账号" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addmember) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (void)addmember {
    [self.navigationController pushViewController:[ChangeSonMemberViewController new] animated:YES];
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}


@end
