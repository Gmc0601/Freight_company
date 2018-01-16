//
//  FirstViewController.m
//  Freight_Dirver
//
//  Created by cc on 2018/1/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "FirstViewController.h"



@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self navigation];
    
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
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
