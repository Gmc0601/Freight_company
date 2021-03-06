//
//  MyDriverViewController.m
//  Freight_Company
//
//  Created by cc on 2018/1/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "MyDriverViewController.h"
#import "MyDriverTableViewCell.h"
#import <MJExtension.h>

@implementation MYDriverModel
@end

@interface MyDriverViewController ()<UITableViewDelegate,  UITableViewDataSource>

@property (nonatomic, retain) UITableView *noUseTableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MyDriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.noUseTableView];
    [HttpRequest postPath:@"/Home/User/driverList" params:nil resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            NSDictionary *data = datadic[@"data"];
            self.dataArr = [MYDriverModel mj_objectArrayWithKeyValuesArray:data];
            [self.noUseTableView reloadData];
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }  
    }];
}

- (void)resetFather {
    self.titleLab.text = @"我的司机";
    self.rightBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = [NSString stringWithFormat:@"%d", indexPath.row];
    MyDriverTableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MyDriverTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    [cell update:self.dataArr[indexPath.row]];
    
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
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeHeight(40))];
            UILabel *lab = [[UILabel alloc] initWithFrame:FRAME(SizeWidth(10), SizeHeight(15), kScreenW - SizeWidth(20), SizeHeight(15))];
            lab.textColor = UIColorFromHex(0x999999);
            lab.font = [UIFont systemFontOfSize:12];
            lab.text = @"以下为与您合作过的司机，下单时可以优先选择分配给他们";
            [view addSubview:lab];
            view;
        });
        _noUseTableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,  SizeHeight(0))];
            view;
        });
    }
    return _noUseTableView;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

@end
