//
//  AddInfoViewController.m
//  Freight_Company
//
//  Created by cc on 2018/1/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "AddInfoViewController.h"

@interface AddInfoViewController ()

@end

@implementation AddInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetFather];
}

- (void)resetFather {
    self.titleLab.text = @"完善企业信息";
    self.rightBar.hidden =  YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
