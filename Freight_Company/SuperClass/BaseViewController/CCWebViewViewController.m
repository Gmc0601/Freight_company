//
//  CCWebViewViewController.m
//  CCWebView
//
//  Created by cc on 2017/11/13.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "CCWebViewViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LoginViewController.h"
#import "TBNavigationController.h"

@interface CCWebViewViewController ()<UIWebViewDelegate, JSObjcDelegate>

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CCWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    
    [self loadWebView];
    
    if (self.titlestr) {
        self.titleLab.text = self.titlestr;
    }else {
       self.titleLab.text = @"资讯详情";
    }
    if (self.type == CCWebViewViewTypePrice) {
        self.titleLab.text = @"";

    }
    self.rightBar.hidden = YES;
}

- (void)createView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
}
//- (void)viewWillDisappear:(BOOL)animated {
//    if (self.titlestr) {
//        self.leftBar.hidden = NO;
//    }else {
//      self.leftBar.hidden = YES;
//    }
//    
//    self.navigationController.navigationBar.hidden = YES;
//    //    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
//    
//}

- (void)loadWebView {
    
    if (self.type == CCWebViewViewTypeNormal) {
        if (self.content) {
            [self.webView loadHTMLString:self.content baseURL:nil];
        }else {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.UrlStr]];
            [self.webView loadRequest:request];
            [self.webView reload];
        }
    }else{
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        [ConfigModel showHud:self];
        NSLog(@"~~~~para:%@", dic);
        WeakSelf(weak)
        [HttpRequest postPath:@"/Home/Public/jgmx" params:dic resultBlock:^(id responseObject, NSError *error) {
            [ConfigModel hideHud:weak];
            NSLog(@"%@", responseObject);
            if([error isEqual:[NSNull null]] || error == nil){
                NSLog(@"success");
            }
            NSDictionary *datadic = responseObject;
            if ([datadic[@"success"] intValue] == 1) {
                [self.webView loadHTMLString:datadic[@"data"] baseURL:nil];
                
            }else {
                NSString *str = datadic[@"msg"];
                [ConfigModel mbProgressHUD:str andView:nil];
            }
        }];
        
        
    }

}


#pragma mark WebViewDelagate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    截获当前H5页面的链接，做相应处理
    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"requestString : %@",requestString);
    
    
    NSArray *components = [requestString componentsSeparatedByString:@"|"];
//    NSLog(@"=components=====%@",components);
    
    
    NSString *str1 = [components objectAtIndex:0];
//    NSLog(@"str1:::%@",str1);
    
    
    NSArray *array2 = [str1 componentsSeparatedByString:@"/"];
//    NSLog(@"array2:====%@",array2);
    
    
    NSInteger coun = array2.count;
    
    NSString *method = array2[coun-1];
    
//    NSLog(@"method:===%@",method);
    
    //    if ([str1 hasPrefix:@"http:"]) {
    ////        链接以什么开头
    //    }
    //    if ([str1 hasSuffix:@"jifen.html"]) {
    ////        链接以什么结尾
    //    }
    //    if ([str1 rangeOfString:@"shop"].location == NSNotFound) {
    ////        不包含某段字符串
    //    }else{
    ////        包含某段字符串
    //    }
    //    if ([str1 containsString:@"shop"]) {
    ////        iOS8以后判断是否包含某段字符串
    //    }
    
    NSString *arrayToString = [components componentsJoinedByString:@","];
//    NSLog(@"------------%@-----------------", arrayToString);
    
    
    //    if ([method isEqualToString:@"jifen.html"])//查看详情，其中红色部分是HTML5跟咱们约定好的，相应H5上的按钮的点击事件后，H5发送超链接，客户端一旦收到这个超链接信号。把其中的点击按钮的约定的信号标示符截取出来跟本地的标示符来进行匹配，如果匹配成功，那么就执行相应的操作，详情见如下所示。
    //    {
    //        return NO;
    //    }else if ([method isEqualToString:@"jifen.html"])
    //    {
    //
    //        return NO;
    //    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    //    返回的H5方法
    
    //js方法名＋参数
    //    NSString* jsCode = @"history.go(-1)";
    
    //调用html页面的js方法
    //    [webView stringByEvaluatingJavaScriptFromString:jsCode];
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context[@"localMethod"] = self;
    
    self.context.exceptionHandler = ^(JSContext *context, JSValue *ex){
        context.exception = ex;
        NSLog(@"异常信息%@",ex);
    };
    
    
}

- (void)getUserToken {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [ConfigModel mbProgressHUD:[ConfigModel getStringforKey:UserToken] andView:nil];
        JSValue *picCallBack = self.context[@"getUserTokenCallBack"];
        [picCallBack callWithArguments:@[[ConfigModel getStringforKey:UserToken]]];
    });
    
}

- (void)reload {
//    NSLog(@"reload");
    dispatch_async(dispatch_get_main_queue(), ^{
        [ConfigModel mbProgressHUD:@"刷新了" andView:nil];
        [self loadWebView];
    });
    
}

- (void)toLogin {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [ConfigModel mbProgressHUD:@"登录" andView:nil];
        LoginViewController *vc = [[LoginViewController alloc] init];
        TBNavigationController *na = [[TBNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:na animated:YES completion:nil];
    });
    
    
}

- (void)showShare {
    dispatch_async(dispatch_get_main_queue(), ^{
        [ConfigModel mbProgressHUD:@"分享" andView:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIWebView *)webView {
    if (!_webView) {
         _webView = [[UIWebView alloc] init];
        _webView.frame = FRAME(0, 64, kScreenW, kScreenH - 64);
        _webView.backgroundColor = [UIColor clearColor];
        _webView.delegate = self;
        _webView.multipleTouchEnabled = YES;
        _webView.autoresizingMask = YES;
    }
    return _webView;
}

@end
