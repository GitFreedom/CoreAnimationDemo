//
//  WJDBaseTabBarController.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJDBaseTabBarController : UITabBarController

/**
 * 添加子控制器
 * @param vc                子控制器
 * @param title             标题
 * @param normalImageName   普通状态下图片
 * @param selectedImageName 选中图片
 * @param isRequired        是否需要包装导航控制器
 */
- (void)addChildVC: (UIViewController *)vc title:(NSString *)title normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired;

@end

NS_ASSUME_NONNULL_END
