//
//  WJDBaseTableViewController.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDBaseViewController.h"

#import "WJDBaseSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJDBaseTableViewController : WJDBaseViewController <UITableViewDataSource,UITableViewDelegate>

/**
 *  表视图
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  数据
 */
@property (nonatomic, strong) NSMutableArray<WJDBaseSectionModel*> *datas;

@end

NS_ASSUME_NONNULL_END
