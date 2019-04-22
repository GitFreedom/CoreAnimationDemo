//
//  WJDJumpManager.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDJumpManager.h"
#import <UIKit/UIViewController.h>
#import <UIKit/UINavigationController.h>

@implementation WJDJumpManager

+ (void)jumpWithJumpType:(WJDJumpType)jumpType SourceVC:(UIViewController *)sourceVC Param:(nullable NSDictionary *)param {
    
    if (!sourceVC) {
        return;
    }
    NSString *vcName;
    switch (jumpType) {
        case WJDJumpType_WebVC: { //网页控制器
            vcName = @"WJDBaseWebViewController";
        }
            break;
        case WJDJumpType_AnimationCategoryDemoVC: { //UIView的动画相关的分类
            vcName = @"WJDAnimationCategoryDemoVC";
        }
            break;
        case WJDJumpType_CoreAnimationDemoVC: { //核心动画
            vcName = @"WJDCoreAnimationDemoVC";
        }
            break;
        case WJDJumpType_AnimationWithBlockDemoVC: { //动画块
            vcName = @"WJDAnimationWithBlockDemoVC";
        }
            break;
        case WJDJumpType_KeyframeAnimationsDemoVC: { //关键帧动画
            vcName = @"WJDKeyframeAnimationsDemoVC";
        }
            break;
        case WJDJumpType_CAPropertyAnimationDemoVC: { //属性动画
            vcName = @"WJDCAPropertyAnimationDemoVC";
        }
            break;
        case WJDJumpType_CATransitionDemoVC: { //转场动画
            vcName = @"WJDCATransitionDemoVC";
        }
            break;
        case WJDJumpType_CAAnimationGroupDemoVC: { //动画组
            vcName = @"WJDCAAnimationGroupDemoVC";
        }
            break;
        case WJDJumpType_CABasicAnimationDemoVC: { //基础动画
            vcName = @"WJDCABasicAnimationDemoVC";
        }
            break;
        case WJDJumpType_CAKeyframeAnimationDemoVC: { //关键帧动画
            vcName = @"WJDCAKeyframeAnimationDemoVC";
        }
            break;
        default:
            break;
    }
    
    if (vcName) {
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        if (param) {
            for (NSString *key in param.allKeys) {
                [vc setValue:param[key] forKey:key];
            }
        }
        [sourceVC.navigationController pushViewController:vc animated:YES];
    }
}

@end
