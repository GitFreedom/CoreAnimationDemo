//
//  UIView+Frame.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "UIView+WJDFrame.h"

@implementation UIView (Frame)

- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect changeFrame = self.frame;
    changeFrame.origin.x = x;
    self.frame = changeFrame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect changeFrame = self.frame;
    changeFrame.origin.y = y;
    self.frame = changeFrame;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect changeFrame = self.frame;
    changeFrame.size.width = width;
    self.frame = changeFrame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect changeFrame = self.frame;
    changeFrame.size.height = height;
    self.frame = changeFrame;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint changeCenter = self.center;
    changeCenter.x = centerX;
    self.center = changeCenter;
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint changeCenter = self.center;
    changeCenter.y = centerY;
    self.center = changeCenter;
}
- (CGFloat)maxX {
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)maxY {
    return self.frame.origin.y + self.frame.size.height;
}

@end
