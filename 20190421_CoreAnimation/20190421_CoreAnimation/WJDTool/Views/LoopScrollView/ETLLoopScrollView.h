//
//  ETLLoopScrollView.h
//  ETLToolProject
//
//  Created by 王俊东 on 2019/1/14.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETLLoopScrollView : UIView

/**
 *  图片数组
 */
@property (nonatomic, copy  ) NSArray<NSString *> *picturesArray;

/**
 *  开始倒计时
 */
- (void)startTimer;
/**
 *  结束倒计时
 */
- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END
