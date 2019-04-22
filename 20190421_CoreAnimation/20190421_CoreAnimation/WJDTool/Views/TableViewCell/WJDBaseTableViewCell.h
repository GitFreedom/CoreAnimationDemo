//
//  WJDBaseTableViewCell.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/16.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJDBaseTableViewCell : UITableViewCell

/**
 *  数据
 */
@property (nonatomic, strong) id data;
/**
 *  代理
 */
@property (nonatomic, weak) id delegate;


@end

NS_ASSUME_NONNULL_END
