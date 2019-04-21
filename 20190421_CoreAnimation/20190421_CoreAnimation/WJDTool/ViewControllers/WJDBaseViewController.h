//
//  WJDBaseViewController.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIViewController+WJDBlankView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WJDNavigationStatus) {
    NavigationStatus_default = 0,
    NavigationStatus_show,
    NavigationStatus_hidden,
};
typedef NS_ENUM(NSInteger, WJDTabbarStatus) {
    TabbarStatus_default = 0,
    TabbarStatus_show,
    TabbarStatus_hidden,
};

typedef void(^VCDidFinishDataBlcok)(UIViewController *viewController, id data, NSString * _Nullable key);

@interface WJDBaseViewController : UIViewController

///**
// *  空白类型
// */
//@property (nonatomic, assign) WJDBlankType blankType;
/**
 *  上个控制器名称
 */
@property (nonatomic, copy  ) NSString    *lastVCName;
/**
 *  单击返回按钮需要返回的控制器名
 */
@property (nonatomic, copy  ) NSString    *backVCName;
/**
 *  是否刷新需要返回控制器的数据 （挨个判断刷新太麻烦，暂时不用)
 */
@property (nonatomic, assign) BOOL        isRefreshBackVCData;
/**
 *  导航栏状态
 */
@property (nonatomic, assign) WJDNavigationStatus   navigationStatus;
/**
 *  tabbar状态
 */
@property (nonatomic, assign) WJDTabbarStatus       tabbarStatus;
/**
 *  控制器回调
 */
@property (nonatomic, copy  ) VCDidFinishDataBlcok  dataBlock;
/**
 *  请求数据
 */
- (void)loadData;
/**
 *  初始化导航栏（需要使用公共的返回按钮，重写的时候记得调用[super setupNavigation]）
 */
- (void)setupNavigation;
/**
 *  初始化视图
 */
- (void)setupViews;
/**
 *  返回（pop）
 */
- (void)back;

@end

NS_ASSUME_NONNULL_END
