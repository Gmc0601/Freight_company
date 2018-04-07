//
//  JYBOrderLogisMapViewCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/4/8.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBOrderLogisMapViewCell.h"
#import "MAMapView.h"
#import <MAMapKit/MAMapKit.h>

@interface JYBOrderLogisMapViewCell ()<MAMapViewDelegate>

@property (nonatomic ,strong)MAMapView *mapView;


@end

@implementation JYBOrderLogisMapViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self.contentView addSubview:self.mapView];
}

- (MAMapView *)mapView{
    if(_mapView){
       _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(150))];
        [_mapView setDelegate:self];
        _mapView.userInteractionEnabled = NO;
    }
    
    return _mapView;
}

@end
