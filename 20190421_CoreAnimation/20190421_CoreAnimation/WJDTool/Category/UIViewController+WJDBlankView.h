//
//  UIViewController+WJDBlankView.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJDBlankVIewCommon.h"

NS_ASSUME_NONNULL_BEGIN

@class WJDBlankView;
@interface UIViewController (WJDBlankView)<WJDBlankViewDelegate>

/**
 *  @brief: 显示
 */
- (WJDBlankView *)showBlankWithFrame:(CGRect)frame Type:(WJDBlankType)type view:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
