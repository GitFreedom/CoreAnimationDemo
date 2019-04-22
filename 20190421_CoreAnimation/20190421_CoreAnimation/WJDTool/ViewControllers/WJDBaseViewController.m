//
//  WJDBaseViewController.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDBaseViewController.h"

#import <objc/runtime.h>
#import "WJDImageProducer.h"
//#import "UIViewController+WJDLoaddingView.h"

@interface WJDBaseViewController ()

@end

@implementation WJDBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self __updateNavigationTabbarStatus];
    if (!objc_getAssociatedObject(self, _cmd)) { //保证在生命周期内只调用一次
        if (self.navigationController.viewControllers.count > 1) {
            [self setupNavigation];
        }
        objc_setAssociatedObject(self, _cmd, @"alreadyLaunched", OBJC_ASSOCIATION_RETAIN);
    }
    else {
        [self loadData];
//        [self removeLoaddingView];
    }
}

- (void)__updateNavigationTabbarStatus {
    
    if (self.navigationStatus == NavigationStatus_hidden) {
        self.navigationController.navigationBarHidden = YES;
    }
    switch (self.tabbarStatus) {
        case TabbarStatus_show: {
            self.tabBarController.tabBar.hidden = NO;
        }
            break;
        case TabbarStatus_hidden: {
            self.tabBarController.tabBar.hidden = YES;
        }
            break;
        default: {
            self.tabBarController.tabBar.hidden = self.navigationController.viewControllers.count > 1;
        }
            break;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if (self.navigationStatus == NavigationStatus_hidden) {
        self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark - LoadData

- (void)loadData {
    
}

- (void)loadMoreData {
    
}

#pragma mark - Setter

//- (void)setBlankType:(WJDBlankType)blankType {
//    
//    _blankType = blankType;
//    [self showBlankWithFrame:CGRectZero Type:_blankType view:self.view];
//}

#pragma mark - Action

- (void)back {
    
    if (self.backVCName) {
        Class backVCClass = NSClassFromString(self.backVCName);
        if ([[backVCClass new] isKindOfClass:[UIViewController class]]) {
            for (WJDBaseViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:backVCClass]) {
//                    if (self.isRefreshBackVCData) {
//                        [vc loadData];
//                    }
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
        }
    }
    else {
//        if (self.isRefreshBackVCData) {
//            NSInteger vcCount = self.navigationController.viewControllers.count;
//            NSInteger index   = vcCount > 1 ? vcCount - 2 : vcCount - 1;
//            WJDBaseViewController *vc = self.navigationController.viewControllers[index];
//            if ([vc isKindOfClass:[WJDBaseViewController class]]) {
//                [vc loadData];
//            }
//        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - PublicMethod

- (void)setupNavigation {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44.0f, 44.0f);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIImage *backImage = [WJDImageProducer arrowImageWithDirection:ArrowDirection_left RenderType:RenderType_stroke Size:CGSizeMake(9.0f, 16.0f) Width:1.0f Color:[UIColor blackColor] NickName:@"blackColor"];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
}

- (void)setupViews {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    
    NSLog(@"\n***%@ dealloc***\n", NSStringFromClass([self class]));
}

@end
