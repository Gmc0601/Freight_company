//
//  OrderViewController.m
//  Freight_Company
//
//  Created by cc on 2018/1/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "OrderViewController.h"
#import "HMSegmentedControl.h"
#import "JYBOrderSingleVC.h"

@interface OrderViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic ,strong)HMSegmentedControl *headTabView;

@property (nonatomic ,strong)UIPageViewController *pageViewController;

@property (nonatomic ,strong)NSArray  *vcArr;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigation];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.headTabView];
    [self.headTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.mas_equalTo(SizeWidth(45));
    }];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.headTabView.mas_bottom);
    }];
    [self.pageViewController didMoveToParentViewController:self];
    [self.pageViewController setViewControllers:@[[self.vcArr objectAtIndex:0]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO completion:nil];
    WeakObj(self);
    self.headTabView.indexChangeBlock = ^(NSInteger index){
        
        [selfWeak.pageViewController setViewControllers:@[[selfWeak.vcArr objectAtIndex:index]]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:NO completion:nil];
    };
    
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

- (void)backAction {
    [[[JYBAlertView alloc] initWithTitle:@"确定联系平台客服？" message:@"400-9999-0000" cancelItem:@"取消" sureItem:@"确认" clickAction:^(NSInteger index) {
        if (index == 1) {
            NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",@"400-9999-0000"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
        }
    }] show];
    
}

#pragma mark -
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    NSInteger index =  [self.vcArr indexOfObject:self.pageViewController.viewControllers.firstObject];
    if (index != NSNotFound) {
        [self.headTabView setSelectedSegmentIndex:index animated:YES];
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.vcArr indexOfObject:viewController];
    if (index >= self.vcArr.count || index <= 0 || index == NSNotFound) {
        return nil;
    }
    
    return [self.vcArr objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.vcArr indexOfObject:viewController];
    if (index >= self.vcArr.count - 1) {
        return nil;
    }
    return [self.vcArr objectAtIndex:index + 1];
}


- (UIPageViewController *)pageViewController
{
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (HMSegmentedControl *)headTabView{
    if (!_headTabView) {
        _headTabView = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部",@"待支付",@"派单中",@"已接单",@"进行中"]];
        _headTabView.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        _headTabView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _headTabView.selectionIndicatorColor = RGB(26, 143, 241);
        _headTabView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _headTabView.selectionIndicatorHeight = 2;
        [_headTabView setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            UIColor *textColor;
            if (selected) {
                textColor = RGB(26, 143, 241);
            } else {
                textColor = RGB(162, 162, 162);
            }
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:textColor,NSFontAttributeName:[UIFont systemFontOfSize:SizeWidth(15)]}];
            return attString;
        }];
    }
    return _headTabView;
}

- (NSArray *)vcArr{
    if (!_vcArr) {
        JYBOrderSingleVC *allVC = [[JYBOrderSingleVC alloc] init];
        allVC.type = JYBOrderTypeAll;
        
        JYBOrderSingleVC *waitpayVC = [[JYBOrderSingleVC alloc] init];
        waitpayVC.type = JYBOrderTypeWait;

        JYBOrderSingleVC *paiingVC = [[JYBOrderSingleVC alloc] init];
        paiingVC.type = JYBOrderTypePai;

        JYBOrderSingleVC *hasreviceVC = [[JYBOrderSingleVC alloc] init];
        hasreviceVC.type = JYBOrderTypeReviced;

        JYBOrderSingleVC *ingVC = [[JYBOrderSingleVC alloc] init];
        ingVC.type = JYBOrderTypeIng;

        _vcArr = @[allVC,waitpayVC,paiingVC,hasreviceVC,ingVC];
    }
    return _vcArr;
}

@end
