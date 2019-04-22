//
//  WJDJumpManager.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

typedef NS_ENUM(NSInteger, WJDJumpType) {
    
    WJDJumpType_unknow = 0,//未知
    WJDJumpType_WebVC,//网页
    WJDJumpType_AnimationCategoryDemoVC,//UIView的动画相关的分类
    WJDJumpType_CoreAnimationDemoVC,//核心动画
    WJDJumpType_AnimationWithBlockDemoVC,//动画块
    WJDJumpType_KeyframeAnimationsDemoVC,//关键帧动画
    WJDJumpType_CAPropertyAnimationDemoVC,//属性动画
    WJDJumpType_CATransitionDemoVC,//转场动画
    WJDJumpType_CAAnimationGroupDemoVC,//动画组
    WJDJumpType_CABasicAnimationDemoVC,//基础动画
    WJDJumpType_CAKeyframeAnimationDemoVC,//关键帧动画
};

NS_ASSUME_NONNULL_BEGIN

@interface WJDJumpManager : NSObject

+ (void)jumpWithJumpType:(WJDJumpType)jumpType SourceVC:(UIViewController *)sourceVC Param:(nullable NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
