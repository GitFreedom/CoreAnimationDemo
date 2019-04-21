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
    WJDJumpType_webVC,//网页
};

NS_ASSUME_NONNULL_BEGIN

@interface WJDJumpManager : NSObject

+ (void)jumpWithJumpType:(WJDJumpType)jumpType SourceVC:(UIViewController *)sourceVC Param:(nullable NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
