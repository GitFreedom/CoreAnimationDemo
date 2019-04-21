//
//  WJDBlankVIewCommon.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#ifndef WJDBlankVIewCommon_h
#define WJDBlankVIewCommon_h

typedef NS_ENUM(NSInteger, WJDBlankType) {
    WJDBlankType_unknow = 0,
    WJDBlankType_noOrderList,//没有订单数据
    WJDBlankType_none,//从父视图移除
};


@protocol WJDBlankViewDelegate <NSObject>

@optional
- (void)blankViewTapAction;

@end

#endif /* WJDBlankVIewCommon_h */
