//
//  WZAnnotationController.m
//  MapTest
//
//  Created by songbiwen on 16/7/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZAnnotationController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "WZCustomAnnotationView.h"

@interface WZAnnotationController ()
<
BMKMapViewDelegate
>

@property (nonatomic, strong) IBOutlet BMKMapView *mapView;

@property (nonatomic, strong) NSArray *array;
@end

@implementation WZAnnotationController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.zoomLevel = 11;
    
    self.array = [NSArray arrayWithObjects:@"one",@"zbz",@"cgx",@"sb",@"cjk",@"senni", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

#pragma mark - BMKMapViewDelegate

/**
 *地图初始化完毕时会调用此接口
 *@param mapview 地图View
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    
    for (int i = 0; i < self.array.count; i ++) {
        
        BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915 + 0.1 * i;
        coor.longitude = 116.404;
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = self.array[i];
        [mapView addAnnotation:pointAnnotation];
    }
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    NSString *AnnotationViewID = @"renameMark";
    WZCustomAnnotationView *annotationView = (WZCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[WZCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.content = annotation.title;
    return annotationView;
    
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"%s",__func__);
    
}
@end
