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
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JYBOrderBoxAddressModel.h"

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

- (void)updateCellWithModel:(JYBOrderListModel *)model{
    
    JYBOrderBoxAddressModel *shipModel = [model.shipment_address firstObject];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:shipModel.lat.floatValue longitude:shipModel.lon.floatValue];

    MAPointAnnotation *pointAnnotaiton = [[MAPointAnnotation alloc] init];
    [pointAnnotaiton setCoordinate:location.coordinate];

    [self.mapView addAnnotation:pointAnnotaiton];
    
    [self.mapView setCenterCoordinate:location.coordinate];
    
    
    [self.mapView setZoomLevel:12 animated:NO];
    
    self.mapView.frame = CGRectMake(0, 0, kScreenW, SizeWidth(150));
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
       _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeWidth(150))];
        [_mapView setDelegate:self];
        _mapView.userInteractionEnabled = NO;

    }
    
    return _mapView;
}

@end
