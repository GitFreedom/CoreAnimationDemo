//
//  WJDBlankView.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDBlankView.h"

@interface WJDBlankView ()

/**
 *  空白页图片
 */
@property (nonatomic, weak  ) UIImageView *imageView;
/**
 *  提示标签
 */
@property (nonatomic, weak  ) UILabel     *tipLabel;
/**
 *  默认字体
 */
@property (nonatomic, strong) UIFont      *defaultFont;
/**
 *  默认字体颜色
 */
@property (nonatomic, strong) UIColor     *defaultColor;
/**
 *  高亮字体颜色
 */
@property (nonatomic, strong) UIColor     *highlightColor;

@end

@implementation WJDBlankView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _defaultFont    = [UIFont systemFontOfSize:15.0f];
        _defaultColor   = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _highlightColor = [UIColor colorWithRed:224/255.0 green:36/255.0  blue:36/255.0  alpha:1.0];
        //空白页图片
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView             = imageView;
        [self addSubview:_imageView];
        //提示标签
        UILabel *tipLabel      = [UILabel new];
        _tipLabel              = tipLabel;
        [self addSubview:_tipLabel];
        
    }
    return self;
}
#pragma mark - setter
- (void)setBlankType:(WJDBlankType)blankType {
    
    switch (blankType) {
        case WJDBlankType_noOrderList:
        {
            UIImage *image = [UIImage imageNamed:@"OnlineEducation_orderList_blank"];
            self.imageView.image = image;
            CGFloat x = (self.frame.size.width  - image.size.width)*0.5;
            CGFloat y = (self.frame.size.height - image.size.height)*0.5 - 42.5f;
            self.imageView.frame = CGRectMake(x, y, image.size.width, image.size.height);
            
            self.tipLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
            self.tipLabel.font      = [UIFont systemFontOfSize:18.0f];
            self.tipLabel.text      = @"请前去网页端下单报名购买";
            self.tipLabel.numberOfLines = 0;
            self.tipLabel.textAlignment = NSTextAlignmentCenter;
            self.tipLabel.frame         = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 15.0f, self.frame.size.width, 30.0f);
            
            self.backgroundColor = [UIColor whiteColor];
        }
            break;
        case WJDBlankType_none://从父视图移除
        {
            [self removeFromSuperview];
        }
            break;
        default:
            break;
    }
}
#pragma mark - Action
- (void)__tapAction {
    
    if ([self.delegate respondsToSelector:@selector(blankViewTapAction)]) {
        [self.delegate blankViewTapAction];
    }
}

@end
