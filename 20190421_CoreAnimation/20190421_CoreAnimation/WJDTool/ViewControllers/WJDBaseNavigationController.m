//
//  WJDBaseViewController.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDBaseNavigationController.h"
#import <UIKit/UIImage.h>
#import "UIImage+WJDAdd.h"

@interface WJDBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WJDBaseNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    //设置导航条的样式
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barStyle = UIBarStyleDefault;
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

/**
 *  当控制器, 拿到导航控制器(需要是这个子类), 进行压栈时, 都会调用这个方法
 *
 *  @param viewController 要压栈的控制器
 *  @param animated       动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIViewController *currentVC = [super topViewController];
    // 拦截每一个push的控制器, 进行统一设置
    // 过滤第一个根控制器
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"WJDBaseViewController")]) {
        [viewController setValue:NSStringFromClass(currentVC.class) forKey:@"lastVCName"];
    }
    [super pushViewController:viewController animated:animated];
}

@end
