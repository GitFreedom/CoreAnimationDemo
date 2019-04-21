//
//  WJDImageProducer.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/17.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDImageProducer.h"

@implementation WJDImageProducer

static NSCache *__imageProducerCache;

#pragma mark - 绘制箭头图片
+ (UIImage *)arrowImageWithDirection:(ArrowDirection)direction
                          RenderType:(RenderType)renderType
                                Size:(CGSize)size
                               Width:(CGFloat)lineWidth
                               Color:(UIColor *)lineColor
                            NickName:(NSString *)lineColorNickName {
    
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    //生成图片在缓存中的key
    NSString *imageKey = [NSString stringWithFormat:@"arrow_%li_%li_%@_%.2f_%@",direction,renderType,NSStringFromCGSize(size),lineWidth,lineColorNickName];
    //如果缓存中存在该图片直接返回该图片
    if (__imageProducerCache) {
        UIImage *image = [__imageProducerCache objectForKey:imageKey];
        if (image) {
            return image;
        }
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //first为顶点 second为顶点向上时左边那个点  third为顶点向上时右边那个点
    CGFloat firstX,firstY,secondX,secondY,thirdX,thirdY;
    switch (direction) {
        case ArrowDirection_left:
        {
            firstX  = 0.0f;
            firstY  = size.height*0.5;
            secondX = size.width;
            secondY = size.height;
            thirdX  = size.width;
            thirdY  = 0.0f;
        }
            break;
        case ArrowDirection_up:
        {
            firstX  = size.width*0.5;
            firstY  = 0.0f;
            secondX = 0.0f;
            secondY = size.height;
            thirdX  = size.width;
            thirdY  = size.height;
        }
            break;
        case ArrowDirection_right:
        {
            firstX  = size.width;
            firstY  = size.height*0.5;
            secondX = 0.0f;
            secondY = 0.0f;
            thirdX  = 0.0f;
            thirdY  = size.height;
        }
            break;
        case ArrowDirection_down:
        {
            firstX  = size.width*0.5;
            firstY  = size.height;
            secondX = size.width;
            secondY = 0.0f;
            thirdX  = 0.0f;
            thirdY  = 0.0f;
        }
            break;
    }
    CGContextSetLineWidth(ref, lineWidth <= 0 ? 1.0f : lineWidth);
    CGContextMoveToPoint(ref, secondX, secondY);
    CGContextAddLineToPoint(ref, firstX, firstY);
    CGContextAddLineToPoint(ref, thirdX, thirdY);
    lineColor ? [lineColor set] : [[UIColor whiteColor] set];
    if (renderType == RenderType_stroke) {
        CGContextStrokePath(ref);
    }
    else {
        CGContextFillPath(ref);
    }
    CGContextStrokePath(ref);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //将生成的图片加入缓存
    if (image) {
        if (!__imageProducerCache) {
            __imageProducerCache = [[NSCache alloc]init];
        }
        [__imageProducerCache setObject:image forKey:imageKey];
    }
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - 绘制矩形图片
+ (UIImage *)rectImageWithRenderType:(RenderType)renderType
                               Size:(CGSize)size
                              Width:(CGFloat)lineWidth
                              Color:(UIColor *)renderColor
                           NickName:(NSString *)renderColorNickName {
    
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    //生成图片在缓存中的key
    NSString *imageKey = [NSString stringWithFormat:@"arrow_%li_%@_%.2f_%@",renderType,NSStringFromCGSize(size),lineWidth,renderColorNickName];
    //如果缓存中存在该图片直接返回该图片
    if (__imageProducerCache) {
        UIImage *image = [__imageProducerCache objectForKey:imageKey];
        if (image) {
            return image;
        }
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    if (lineWidth > 0) {
        CGContextSetLineWidth(ref,lineWidth);
    }
    CGContextAddRect(ref, CGRectMake(0, 0, size.width, size.height));
    renderColor ? [renderColor set] : [[UIColor whiteColor] set];
    if (renderType == RenderType_stroke) {
        CGContextStrokePath(ref);
    }
    else {
        CGContextFillPath(ref);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //将生成的图片加入缓存
    if (image) {
        if (!__imageProducerCache) {
            __imageProducerCache = [[NSCache alloc]init];
        }
        [__imageProducerCache setObject:image forKey:imageKey];
    }
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - 绘制图片
+ (UIImage *)imageWithSize:(CGSize)size
                 DrawBlock:(void(^)(CGContextRef context, CGRect rect))drawBlock {
    
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    if (!drawBlock) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    drawBlock(ref,CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
