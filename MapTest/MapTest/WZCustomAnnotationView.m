//
//  WZCustomAnnotationView.m
//  MapTest
//
//  Created by songbiwen on 16/7/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZCustomAnnotationView.h"

@implementation WZCustomAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        self.bounds = CGRectMake(0, 0, 100, 30);
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews {
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIButton *content_button = [UIButton buttonWithType:UIButtonTypeCustom];
    content_button.frame = CGRectMake(0, 0, width * 0.6, height);
//    [content_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    content_button.titleLabel.font = [UIFont systemFontOfSize:15];
    content_button.backgroundColor = [UIColor darkGrayColor];
    [content_button addTarget:self action:@selector(content_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:content_button];
    self.content_button  = content_button;
    
    UIButton *nav_button = [UIButton buttonWithType:UIButtonTypeCustom];
    nav_button.frame = CGRectMake(width * 0.6, 0, width * 0.4, height);
    //    [nav_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    nav_button.titleLabel.font = [UIFont systemFontOfSize:15];
    nav_button.backgroundColor = [UIColor redColor];
    [nav_button addTarget:self action:@selector(nav_buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nav_button];
    self.nav_button  = nav_button;
    [self.nav_button setTitle:@"导航" forState:UIControlStateNormal];
}


- (void)setContent:(NSString *)content {
    _content = content;
    
    [self.content_button setTitle:content forState:UIControlStateNormal];

}

- (void)content_buttonAction {
    NSLog(@"%s",__func__);
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:self.content_button.titleLabel.text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:action];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
}

- (void)nav_buttonAction {
    NSLog(@"%s",__func__);
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:self.nav_button.titleLabel.text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:action];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
    
}


@end
