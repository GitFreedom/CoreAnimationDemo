//
//  UIImage+WJDAdd.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WJDAdd)
/**
 *  根据颜色生成图片
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color;
/**
 *  根据颜色，尺寸生成图片
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size;
/**
 *  修正图片方向
 */
- (UIImage *)fixOrientation;
/**
 *  改变图片大小
 */
- (UIImage *)resizeImageToSize:(CGSize)maxSize;
/**
 *  压缩图片到指定大小以下
 */
- (UIImage *)compressImageToByte:(NSInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
