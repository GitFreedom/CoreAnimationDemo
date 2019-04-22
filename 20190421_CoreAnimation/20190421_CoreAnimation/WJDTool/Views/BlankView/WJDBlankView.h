//
//  WJDBlankView.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJDBlankVIewCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJDBlankView : UIView

/**
 *  类型
 */
@property (nonatomic, assign) WJDBlankType blankType;
/**
 *  代理
 */
@property (nonatomic, weak) id<WJDBlankViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
