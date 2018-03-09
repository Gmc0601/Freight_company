//
//  ChangeSonMemberViewController.m
//  Freight_Company
//
//  Created by cc on 2018/1/19.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ChangeSonMemberViewController.h"
#import "AddInfoTableViewCell.h"

@interface ChangeSonMemberViewController ()<UITableViewDelegate,  UITableViewDataSource>

@property (nonatomic, retain) UITableView *noUseTableView;

@property (nonatomic, strong) UITextField *text1, *text2;

@property (nonatomic, retain) NSArray *titleArr, *pleaceArr;

@property (nonatomic, retain) UIButton *addBtn;

@end

@implementation ChangeSonMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    [self.view addSubview:self.noUseTableView];
    [self.view addSubview:self.addBtn];
}

- (void)resetFather {
    self.titleLab.text = @"编辑子账号";
    self.rightBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = [NSString stringWithFormat:@"%d", indexPath.row];
    AddInfoTableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AddInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        UILabel *line = [[UILabel alloc] initWithFrame:FRAME(0, SizeHeight(55) - 1, kScreenW, 1)];
        line.backgroundColor = RGB(239, 240, 241);
        [cell.contentView addSubview:line];
    }
    if (indexPath.row == 0) {
        self.text1 = cell.text;
    }else {
        self.text2 = cell.text;
    }
    if (self.type == ChangeInfo) {
        self.text1.text = self.model.company_user_name;
        self.text2.text = self.model.company_user_phone;
    }
    cell.title = self.titleArr[indexPath.row];
    cell.text.placeholder = self.pleaceArr[indexPath.row];
    WeakSelf(weak);
    cell.textBlock = ^(NSString *text) {
        
    };
    
    return cell;
    
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SizeHeight(55);
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

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"员工姓名", @"手机号"];
    }
    return _titleArr;
}

- (NSArray *)pleaceArr {
    if (!_pleaceArr) {
        _pleaceArr = @[@"请输入员工姓名", @"请输入11位手机号"];
    }
    return _pleaceArr;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:FRAME(SizeWidth(10), kScreenH - SizeHeight(50), kScreenW - SizeWidth(20), SizeHeight(40))];
        _addBtn.backgroundColor = UIColorFromHex(0x018BF2);
        [_addBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addmember) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (void)addmember {
    //  baocun
    if (!self.text1.text) {
        [ConfigModel mbProgressHUD:@"请输入员工姓名" andView:nil];
    }
    
    if (self.text2.text.length != 11) {
        [ConfigModel mbProgressHUD:@"请输入手机号" andView:nil];
    }
//    company_user_id   ...  子账号user_id 编辑时必填
    NSDictionary* dic = @{
                          @"company_user_name" : self.text1.text,
                          @"company_user_phone" : self.text2.text
                          };
    
    [HttpRequest postPath:@"" params:dic resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            [ConfigModel mbProgressHUD:@"操作成功" andView:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    

}


@end
