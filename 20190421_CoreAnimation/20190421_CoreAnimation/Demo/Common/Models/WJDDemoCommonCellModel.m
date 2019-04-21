//
//  WJDDemoCommonCellModel.m
//  20190421_CoreAnimation
//
//  Created by 王俊东 on 2019/4/22.
//  Copyright © 2019 王俊东. All rights reserved.
//

#import "WJDDemoCommonCellModel.h"

@implementation WJDDemoCommonCellModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.className = @"WJDDemoCommonTableViewCell";
        self.cellHeight = 50.0f;
    }
    return self;
}

@end
