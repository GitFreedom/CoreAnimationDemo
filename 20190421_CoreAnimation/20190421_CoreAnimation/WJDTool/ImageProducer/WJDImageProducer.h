//
//  WJDImageProducer.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/17.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ArrowDirection) {//方向
    ArrowDirection_left = 0,//箭头向左
    ArrowDirection_up,//箭头向上
    ArrowDirection_right,//箭头向右
    ArrowDirection_down//箭头向下
};
typedef NS_ENUM(NSInteger, RenderType) {//渲染类型
    RenderType_fill = 0,//实心
    RenderType_stroke,//空心
};
NS_ASSUME_NONNULL_BEGIN

@interface WJDImageProducer : NSObject

/**
 *  @brief  : 根据方向、尺寸、线颜色、线宽度绘制箭头图片
 *  @param    direction 箭头方向
 *  @param    size      箭头大小
 *  @param    lineWidth 箭头线宽度
 *  @param    lineColor 箭头颜色
 *  @param    lineColorNickName 箭头颜色别名用来缓存生成的图片
 *  @return : 返回绘制好的图片
 */
+ (UIImage *)arrowImageWithDirection:(ArrowDirection)direction
                          RenderType:(RenderType)renderType
                                Size:(CGSize)size
                               Width:(CGFloat)lineWidth
                               Color:(UIColor *)lineColor
                            NickName:(NSString *)lineColorNickName;

/**
 *  @brief  : 根据渲染类型、尺寸、线颜色、线宽度绘制矩形图片
 *  @param    renderType  渲染类型
 *  @param    size        矩形大小
 *  @param    lineWidth   矩形线宽度
 *  @param    renderColor 矩形颜色
 *  @param    renderColorNickName 箭头颜色别名用来缓存生成的图片
 *  @return : 返回绘制好的图片
 */
+ (UIImage *)rectImageWithRenderType:(RenderType)renderType
                                Size:(CGSize)size
                               Width:(CGFloat)lineWidth
                               Color:(UIColor *)renderColor
                            NickName:(NSString *)renderColorNickName;
/**
 *  @brief  : 绘制一个图片
 *  @param    size        图片大小
 *  @param    drawBlock   在图片上进行绘制的block
 *  @return : 返回绘制好的图片
 */
+ (UIImage *)imageWithSize:(CGSize)size
                       DrawBlock:(void(^)(CGContextRef context, CGRect rect))drawBlock;
@end

NS_ASSUME_NONNULL_END
