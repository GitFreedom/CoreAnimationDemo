//
//  ETLLoopScrollView.m
//  ETLToolProject
//
//  Created by 王俊东 on 2019/1/14.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "ETLLoopScrollView.h"
#import "YYTimer.h"
#import "UIImageView+YYWebImage.h"

@interface ETLLoopScrollView ()<UIScrollViewDelegate>

/**
 *  左视图
 */
@property (nonatomic, strong) UIImageView  *leftImageView;
/**
 *  中间视图
 */
@property (nonatomic, strong) UIImageView  *centerImageView;
/**
 *  右视图
 */
@property (nonatomic, strong) UIImageView  *rightImageView;
/**
 *  滑动视图
 */
@property (nonatomic, weak  ) UIScrollView *scrollView;
/**
 *  计时器
 */
@property (nonatomic, strong) YYTimer      *timer;

/**
 *  当前页
 */
@property (nonatomic, assign) NSInteger    currentPage;

@end

@implementation ETLLoopScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //滑动视图
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsVerticalScrollIndicator   = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled                  = YES;
        scrollView.delegate = self;
        _scrollView = scrollView;
        [self addSubview:_scrollView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (CGRectEqualToRect(self.scrollView.frame, CGRectZero)) {
        [self __updateFrames];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"scrollView.contentOffset = %@", NSStringFromCGPoint(scrollView.contentOffset));
    if ( scrollView.contentOffset.x < 0 ) {
        [scrollView setContentOffset: CGPointMake(CGRectGetWidth(scrollView.frame), 0)];
        self.currentPage = [self __validatePageIndex:self.currentPage - 1];;
        [self __updatePagesContent];
    }
    else if ( scrollView.contentOffset.x > CGRectGetWidth(scrollView.frame) * 2 ) {
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0)];
        self.currentPage = [self __validatePageIndex:self.currentPage + 1];
        [self __updatePagesContent];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
    if (!decelerate) {
        [self __adjustScrollViewContentOffset];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self __adjustScrollViewContentOffset];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self __adjustScrollViewContentOffset];
}
#pragma mark - getter
- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.clipsToBounds   = YES;
        _leftImageView.contentMode     = UIViewContentModeScaleAspectFill;
        _leftImageView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        [self.scrollView addSubview:_leftImageView];
    }
    return _leftImageView;
}
- (UIImageView *)centerImageView {
    
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]init];
        _centerImageView.clipsToBounds   = YES;
        _centerImageView.contentMode     = UIViewContentModeScaleAspectFill;
        _centerImageView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        [self.scrollView addSubview:_centerImageView];
    }
    return _centerImageView;
}
- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.clipsToBounds   = YES;
        _rightImageView.contentMode     = UIViewContentModeScaleAspectFill;
        _rightImageView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        [self.scrollView addSubview:_rightImageView];
    }
    return _rightImageView;
}
#pragma mark - setter
- (void)setPicturesArray:(NSArray<NSString *> *)picturesArray {
    
    _picturesArray = picturesArray;
    [self __updateFrames];
}
#pragma mark - publicMethod
- (void)startTimer {
    
    self.timer = [[YYTimer alloc]initWithFireTime:5.0f interval:5.0f target:self selector:@selector(__timerSelector) repeats:YES];
}
- (void)stopTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - privateMethod
//更新frame
- (void)__updateFrames {
    
    self.scrollView.frame = self.bounds;
    if (_picturesArray.count < 2) {
        self.centerImageView.frame  = self.scrollView.bounds;
        self.scrollView.contentSize = self.scrollView.bounds.size;
        self.scrollView.bounces     = NO;
    }
    else {
        CGFloat width               = self.scrollView.frame.size.width;
        CGFloat height              = self.scrollView.frame.size.height;
        self.leftImageView.frame    = self.scrollView.bounds;
        self.centerImageView.frame  = CGRectMake(width,   0, width, height);
        self.rightImageView.frame   = CGRectMake(width*2, 0, width, height);
        self.scrollView.contentSize = CGSizeMake(width*3, height);
        self.scrollView.bounces     = YES;
        [self startTimer];
    }
    [self __updatePagesContent];
//    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
}
//获取矫正后的页码
- (NSInteger)__validatePageIndex:(NSInteger)pageIndex {
    
    if (pageIndex < 0) {
        return _picturesArray.count - 1;
    }
    else if (pageIndex >= _picturesArray.count) {
        return 0;
    }
    return pageIndex;
}
//下一页
- (void)__nextPage {
    
    CGPoint point = _scrollView.contentOffset;
    point.x += CGRectGetWidth(_scrollView.frame);
    NSInteger iWidth = (NSInteger)CGRectGetWidth(_scrollView.frame);
    NSInteger iX = (NSInteger)point.x;
    if (iX % iWidth != 0) {
        NSInteger iPage = iX / iWidth;
        iPage++;
        point.x = iPage * iWidth;
    }
    [_scrollView setContentOffset:point animated:YES];
    [self scrollViewDidScroll:_scrollView];
}
//更新页面内容
- (void)__updatePagesContent {
    
    if (_picturesArray.count < 2) {
        [self __imageView:self.centerImageView UpdateImageWithStr:_picturesArray[0]];
    }
    else {
        NSInteger lastIndex = [self __validatePageIndex:self.currentPage - 1];
        NSInteger nextIndex = [self __validatePageIndex:self.currentPage + 1];
        [self __imageView:self.leftImageView   UpdateImageWithStr:_picturesArray[lastIndex]];
        [self __imageView:self.centerImageView UpdateImageWithStr:_picturesArray[self.currentPage]];
        [self __imageView:self.rightImageView  UpdateImageWithStr:_picturesArray[nextIndex]];
    }
}
- (void)__adjustScrollViewContentOffset {
    
//    NSLog(@"\n******startContentOffset = %@",NSStringFromCGPoint(_scrollView.contentOffset));
    CGPoint point    = _scrollView.contentOffset;
    NSInteger iWidth = (NSInteger)CGRectGetWidth(_scrollView.frame);
    NSInteger iX     = (NSInteger)point.x;
    if (iX % iWidth != 0) {
        NSInteger iPage = iX / iWidth;
        iPage++;
        point.x = iPage * iWidth;
    }
//    NSLog(@"\n******endContentOffset = %@",NSStringFromCGPoint(point));
    [self.scrollView setContentOffset:point];
}
- (void)__imageView:(UIImageView *)imageView UpdateImageWithStr:(NSString *)str {
    
    if ([str hasPrefix:@"http"]) {
        imageView.imageURL = [NSURL URLWithString:str];
    }
    else {
        imageView.image    = [UIImage imageNamed:str];
    }
}
#pragma mark  Timer
- (void)__timerSelector {
    
    [self __nextPage];
}

@end
