//
//  UITabBar+TBBadge.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/19.
//  Copyright © 2017年 lujh. All rights reserved.
//

#define TabbarItemNums 3.0    //tabbar的数量

#import "UITabBar+TBBadge.h"

@implementation UITabBar (TBBadge)

- (void)showBadgeOnItemIndex:(int)index count:(NSInteger)count{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UILabel *badgeView = [[UILabel alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 8;
    badgeView.layer.masksToBounds = YES;
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.textColor = [UIColor whiteColor];
    badgeView.font = [UIFont systemFontOfSize:9];
    badgeView.textAlignment = NSTextAlignmentCenter;
    badgeView.text = [NSString stringWithFormat:@"%ld",count];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.5) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 16, 16);
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

@end
