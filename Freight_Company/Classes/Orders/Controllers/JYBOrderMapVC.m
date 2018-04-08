//
//  JYBOrderMapVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/4/9.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBOrderMapVC.h"
#import "MAMapView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JYBOrderBoxAddressModel.h"

@interface JYBOrderMapVC ()<MAMapViewDelegate>

@property (nonatomic ,strong)MAMapView *mapView;

@property (nonatomic ,strong)UIButton *backBtn;

@end

@implementation JYBOrderMapVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self resetFather];
    
    [self.view addSubview:self.mapView];
    
    
    [self.view addSubview:self.backBtn];
    
    
    [self setUIWithModel:self.listModel];
    
}

- (void)resetFather {
    self.navigationView.hidden = YES;
    
}

- (void)setUIWithModel:(JYBOrderListModel *)model{
    
    JYBOrderBoxAddressModel *shipModel = [model.shipment_address firstObject];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:shipModel.lat.floatValue longitude:shipModel.lon.floatValue];
    
    MAPointAnnotation *pointAnnotaiton = [[MAPointAnnotation alloc] init];
    [pointAnnotaiton setCoordinate:location.coordinate];
    
    [self.mapView addAnnotation:pointAnnotaiton];
    
    [self.mapView setCenterCoordinate:location.coordinate];
    
    [self.mapView setZoomLevel:12 animated:NO];
}

/*!
 @brief 根据anntation生成对应的View
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"ckqp_icon_nhd"];
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView;
    }
    
    return nil;
}


- (MAMapView *)mapView{
    if(!_mapView){
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [_mapView setDelegate:self];
    }
    
    return _mapView;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 44, 44)];
        [_backBtn setImage:[UIImage imageNamed:@"qpdt_icon_fh"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
