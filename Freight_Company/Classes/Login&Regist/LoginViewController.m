
//
//  LoginViewController.m
//  BaseProject
//
//  Created by cc on 2017/12/12.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "LoginViewController.h"
#import "CCWebViewViewController.h"
#import "AddInfoViewController.h"
#import <MJExtension.h>
#import "ReviewViewController.h"
#import "ViewController.h"


@implementation UserModel


@end

@implementation CompanyInfo


@end


@interface LoginViewController (){
    NSString *UserAgreeContent;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.line.hidden= YES;
    self.rightBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view1.layer.masksToBounds = YES;
    self.view2.layer.masksToBounds = YES;
    self.view1.layer.borderWidth = 1;
    self.view2.layer.borderWidth = 1;
    self.view1.layer.borderColor = [UIColorFromHex(0x999999) CGColor];
    self.view2.layer.borderColor = [UIColorFromHex(0x999999) CGColor];
    [self.leftBar setImage:[UIImage imageNamed:@"dl_icon_sc"] forState:UIControlStateNormal];
    [self.phoneText addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
    [self.codeText addTarget:self action:@selector(textchange) forControlEvents:UIControlEventEditingChanged];
 
    
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
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    self.leftBar.hidden = NO;
    
}

- (void)back:(UIButton *)sender {
    if (self.homeBlocl) {
        self.homeBlocl();
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    });
   
    
}

- (void)textchange {

}

- (IBAction)codeBtnClick:(id)sender {
//    [ConfigModel mbProgressHUD:@"发送成功" andView:nil];
    
    if (self.phoneText.text.length != 11) {
        [ConfigModel mbProgressHUD:@"请输入11位有效手机号" andView:nil];
        return;
    }
    WeakSelf(weak);
    NSDictionary *dic = @{
                          @"phone" : self.phoneText.text,
                          };
    [HttpRequest postPath:@"/Home/Public/sendCode" params:dic resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            [ConfigModel mbProgressHUD:@"发送成功" andView:nil];
            __block int timeout=59 ; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        
//                        [weak.codeBtn setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
                        [weak.codeBtn setTitle:@"重获验证码" forState:UIControlStateNormal];
                        weak.codeBtn .userInteractionEnabled = YES;
                    });
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        NSString *strTime = [NSString stringWithFormat:@"%d", timeout];
                        [self.codeBtn setTitle:[NSString stringWithFormat:@"(%@s)",strTime] forState:UIControlStateNormal];
                        weak.codeBtn .userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }

    }];
    
   
}
- (IBAction)loginBtnClick:(id)sender {
    //  登录
    
    if (self.phoneText.text.length != 11) {
        [ConfigModel mbProgressHUD:@"请输入11位手机号" andView:nil];
        return;
    }
    
    
    if (self.codeText.text.length != 4) {
        [ConfigModel mbProgressHUD:@"请输入4位验证码" andView:nil];
        return;
    }
    
    NSDictionary *dic = @{
                          @"phone" :self.phoneText.text,
                          @"vcode" : self.codeText.text
                          };
    
    [HttpRequest postPath:@"/Home/Public/login" params:dic resultBlock:^(id responseObject, NSError *error) {
        
        NSLog(@"%@", responseObject);
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            
            NSDictionary *data = datadic[@"data"];
            
            UserModel *user = [UserModel mj_objectWithKeyValues:data];
            if (IsNULL(user.company_info)) {
                //   为空去填写 企业资料
                AddInfoViewController *add = [[AddInfoViewController alloc] init];
                AddInfoModel *model = [[AddInfoModel alloc] init];
                model.user_id = user.user_id;
                model.company_id = user.company_id;
                add.model = model;
                [self.navigationController pushViewController:add animated:YES];
                
            }else {
                //   不为空  判断 用户状态  企业状态
                if ([user.status  intValue] == 0 ) {
                    ReviewViewController *vc = [[ReviewViewController alloc] init];
                    if ([user.company_info.company_status intValue] == 1) {
                        [ConfigModel saveString:user.user_id forKey:UserId];
                        [ConfigModel saveBoolObject:YES forKey:IsLogin];
                        [self dismissViewControllerAnimated:YES completion:nil];
//                        [self presentViewController:[ViewController new] animated:YES completion:nil];
                    }else if ([user.company_info.company_status intValue] == 0 ){
                        vc.type = Reviewing;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        vc.type = ReviewError;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }else {// 用户被禁用
                    ReviewViewController *vc = [[ReviewViewController alloc] init];
                    vc.type = ReviewError;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
    
}

- (IBAction)weichatClick:(id)sender {
    
    
}

- (IBAction)userAgreeClick:(id)sender {
    CCWebViewViewController *vc = [[CCWebViewViewController alloc] init];
    vc.titlestr = @"注册协议";
    vc.content = UserAgreeContent;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
