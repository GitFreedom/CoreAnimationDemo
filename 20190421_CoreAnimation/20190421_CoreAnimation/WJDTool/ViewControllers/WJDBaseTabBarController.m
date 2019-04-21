//
//  WJDBaseTabBarController.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDBaseTabBarController.h"
#import "WJDImageProducer.h"

@interface WJDBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation WJDBaseTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.delegate = self;
    [self addchlidVcs];
    
    // 设置tabbar样式
    [self setTabBarItemStyle];
    [[UITabBar appearance] setTranslucent:NO];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param normalImageName   一般图片名称
 *  @param selectedImageName 选中图片名称
 */
- (void)addChildVC: (UIViewController *)vc  title:(NSString *)title normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired {
    
    if (isRequired) {
        UINavigationController *nav = [[NSClassFromString(@"WJDBaseNavigationController") alloc] initWithRootViewController:vc];
        vc.navigationItem.title = title;
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[self originImageWithName:normalImageName] selectedImage:[self originImageWithName:selectedImageName]];
        
        [self addChildViewController:nav];
    }
    else {
        [self addChildViewController:vc];
    }
}
- (void)addchlidVcs {
    
    NSArray *vcClassArray = @[];
    NSArray *vcTitleArray = @[];
    for (NSInteger i = 0; i < vcClassArray.count; i++) {
        Class class = NSClassFromString(vcClassArray[i]);
        UIViewController *vc = [class new];
        if (i == 1) {
            vc.title = vcClassArray[i];
        }
        [self addChildVC:vc title:vcTitleArray[i] normalImageName:[NSString stringWithFormat:@"Tabbar_normal%li",i] selectedImageName:[NSString stringWithFormat:@"Tabbar_highlight%li",i] isRequiredNavController:YES];
    }
}

- (void)setTabBarItemStyle {
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:10.0f]} forState:UIControlStateNormal];
    
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:32/255.0 green:144/255.0 blue:234/255.0 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:10.0f]} forState:UIControlStateSelected];
}

- (UIImage *)originImageWithName:(NSString *)imageName {
    
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
