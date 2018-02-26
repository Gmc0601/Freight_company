//
//  JYBHomeBoxInfoSpecView.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeBoxInfoSpecView.h"
#import "JYBHomeSpecItemCell.h"

// 各个栏目之间的距离
#define MKPSpace 10.0
// LgCustomAlertW 宽

@interface JYBHomeBoxInfoSpecView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic ,strong)UITableView *myTableView;

/** 弹窗 */
@property(nonatomic,strong) UIView *alertView;

@property (nonatomic,copy) JYBHomeQuickOrderResult myCall;

@end

@implementation JYBHomeBoxInfoSpecView

- (instancetype)initWithArr:(NSMutableArray *)arr clickAction:(JYBHomeQuickOrderResult)action{
    if (self = [super init]) {
        [self setupArr:arr clickAction:action];
    }
    return self;
}

- (void)setupArr:(NSMutableArray *)arr clickAction:(JYBHomeQuickOrderResult)action{
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    
    self.alertView = [[UIView alloc]init];
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.layer.cornerRadius = 5.0;
    self.alertView.frame = CGRectMake(kScreenW - SizeWidth(120), 80, SizeWidth(120), SizeWidth(200));
    self.alertView.clipsToBounds = YES;
    [self addSubview:self.alertView];
    
    [self.alertView addSubview:self.myTableView];
    
    self.myCall = action;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletap:)];
    ges.cancelsTouchesInView = NO;
    [self addGestureRecognizer:ges];
    
}

- (void)handletap:(UITapGestureRecognizer *)tapGes{
    if (tapGes.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [tapGes locationInView:nil];
        if (![self.alertView pointInside:[self.alertView convertPoint:location fromView:self.alertView.window] withEvent:nil]) {
            [self dismiss];
        }
        
    }
    
}



#pragma mark - 弹出
-(void)show
{
    UIWindow *rootWindow = [[[UIApplication sharedApplication] delegate] window];
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

-(void)creatShowAnimation
{
    self.alertView.transform = CGAffineTransformMakeScale(0.80, 0.80);
    [UIView animateWithDuration:0.25 delay:0.05 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SizeWidth(40);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JYBHomeSpecItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeSpecItemCell class]) forIndexPath:indexPath];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.myCall) {
        self.myCall(indexPath.row);
    }
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
        self.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
        self.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SizeWidth(120), SizeWidth(200)) style:UITableViewStylePlain];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[JYBHomeSpecItemCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeSpecItemCell class])];
    }
    return _myTableView;
}



@end
