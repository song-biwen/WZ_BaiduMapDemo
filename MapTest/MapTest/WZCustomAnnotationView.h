//
//  WZCustomAnnotationView.h
//  MapTest
//
//  Created by songbiwen on 16/7/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface WZCustomAnnotationView : BMKAnnotationView
@property (nonatomic, strong) UIButton *content_button;//内容
@property (nonatomic, strong) UIButton *nav_button;//导航

@property (nonatomic, strong) NSString *content; //内容
@end
