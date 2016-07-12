//
//  WZBaiduController.m
//  MapTest
//
//  Created by songbiwen on 16/7/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZBaiduController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "MyAnimatedAnnotationView.h"

@interface WZBaiduController ()
<
BMKMapViewDelegate,
BMKLocationServiceDelegate
>

{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    BMKPointAnnotation* pointAnnotation;
    BMKPointAnnotation* animatedAnnotation;
    
}

@end

@implementation WZBaiduController

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:mapView];
    _mapView = mapView;
    
    [_mapView setZoomLevel:11];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [self addAnnotation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


- (void)addAnnotation {
    //添加标注
    [self addPointAnnotation];
    [self addAnimatedAnnotation];
    //    [_mapView showAnnotations:@[pointAnnotation,animatedAnnotation] animated:YES];
    [_mapView selectAnnotation:pointAnnotation animated:YES];
    [_mapView selectAnnotation:animatedAnnotation animated:YES];
}

//添加标注
- (void)addPointAnnotation
{
    if (pointAnnotation == nil) {
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"test";
        pointAnnotation.subtitle = @"此Annotation可拖拽!";
    }
    [_mapView addAnnotation:pointAnnotation];
    //    [_mapView selectAnnotation:pointAnnotation animated:YES];
}

// 添加动画Annotation
- (void)addAnimatedAnnotation {
    if (animatedAnnotation == nil) {
        animatedAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 40.115;
        coor.longitude = 116.404;
        animatedAnnotation.coordinate = coor;
        animatedAnnotation.title = @"我是动画Annotation";
    }
    [_mapView addAnnotation:animatedAnnotation];
    //    [_mapView selectAnnotation:pointAnnotation animated:YES];
}

#pragma mark - BMKMapViewDelegate

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    if (annotation == pointAnnotation) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = YES;
            //paopao
            
            UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
            popView.backgroundColor = [UIColor redColor];
            //            //设置弹出气泡图片
            //            UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenzi"]];
            //            image.frame = CGRectMake(0, 0, 100, 60);
            //            [popView addSubview:image];
            //自定义显示的内容
            UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 100, 20)];
            driverName.text = @"张XX师傅";
            driverName.backgroundColor = [UIColor clearColor];
            driverName.font = [UIFont systemFontOfSize:14];
            driverName.textColor = [UIColor whiteColor];
            driverName.textAlignment = NSTextAlignmentCenter;
            [popView addSubview:driverName];
            
            UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 20)];
            carName.text = @"京A123456";
            carName.backgroundColor = [UIColor clearColor];
            carName.font = [UIFont systemFontOfSize:14];
            carName.textColor = [UIColor whiteColor];
            carName.textAlignment = NSTextAlignmentCenter;
            [popView addSubview:carName];
            
            annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:popView];
        }
        
        //        annotationView.selected = YES;
        return annotationView;
    }
    
    //动画annotation
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    MyAnimatedAnnotationView *annotationView = nil;
    if (annotationView == nil) {
        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"poi_%d.png", i]];
        [images addObject:image];
    }
    annotationView.annotationImages = images;
    //    annotationView.selected = YES;
    return annotationView;
    
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    
    NSLog(@"%s",__func__);
    
    NSArray *annotations = mapView.annotations;
}

#pragma mark -
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
    [_mapView updateLocationData:userLocation];
    CLLocationCoordinate2D annotation = userLocation.location.coordinate;
    NSLog(@"%s",__func__);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    
    CLLocationCoordinate2D annotation = userLocation.location.coordinate;
    NSLog(@"%s",__func__);
}


@end
