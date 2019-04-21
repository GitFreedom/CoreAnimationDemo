//
//  UIViewController+WJDBlankView.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "UIViewController+WJDBlankView.h"
#import <objc/runtime.h>
#import "WJDBlankView.h"

static const char * WJDViewControllerBlankKey = "WJDViewControllerBlankKey";

@implementation UIViewController (WJDBlankView)

- (WJDBlankView *)blankView {
    
    WJDBlankView *result = objc_getAssociatedObject(self, WJDViewControllerBlankKey);
    if (result == nil) {
        result = [[WJDBlankView alloc] initWithFrame:CGRectZero];
        objc_setAssociatedObject(self, WJDViewControllerBlankKey, result, OBJC_ASSOCIATION_RETAIN);
        result.delegate = self;
    }
    return result;
}

- (WJDBlankView *)showBlankWithFrame:(CGRect)frame Type:(WJDBlankType)type view:(UIView *)view {
    
    [view addSubview:self.blankView];
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(15.0f, 30.0f, view.frame.size.width - 30.0f, view.frame.size.height - 30.0f);
    }
    self.blankView.frame = frame;
    self.blankView.blankType = type;
    [view bringSubviewToFront:self.blankView];
    return self.blankView;
}

@end
