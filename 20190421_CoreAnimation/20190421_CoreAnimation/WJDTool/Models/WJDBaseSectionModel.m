//
//  WJDBaseSectionModel.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDBaseSectionModel.h"

@implementation WJDBaseSectionModel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _headerHeight = CGFLOAT_MIN;
        _footerHeight = CGFLOAT_MIN;
        _headerSize = CGSizeZero;
        _footerSize = CGSizeZero;
        _cellDatas = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
