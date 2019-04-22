//
//  WJDDemoCommonCellModel.h
//  20190421_CoreAnimation
//
//  Created by 王俊东 on 2019/4/22.
//  Copyright © 2019 王俊东. All rights reserved.
//

#import "WJDBaseCellModel.h"
#import "WJDJumpManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJDDemoCommonCellModel : WJDBaseCellModel

/**
 *  标题
 */
@property (nonatomic, copy  ) NSString *title;
/**
 *  跳转类型
 */
@property (nonatomic, assign) WJDJumpType jumpType;

@end

NS_ASSUME_NONNULL_END
