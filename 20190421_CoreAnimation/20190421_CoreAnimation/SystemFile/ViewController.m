//
//  ViewController.m
//  20190421_CoreAnimation
//
//  Created by 王俊东 on 2019/4/21.
//  Copyright © 2019 王俊东. All rights reserved.
//

#import "ViewController.h"

#import "WJDDemoCommonCellModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    self.tabbarStatus = TabbarStatus_hidden;
    [super viewDidLoad];
    
    [self _configInit];
}

#pragma mark - Private

- (void)_configInit {
    
    self.title = @"iOS动画";
    NSArray *titleArray = @[@"UIView的动画相关分类例子",@"核心动画例子"];
    WJDBaseSectionModel *sectionModel = [[WJDBaseSectionModel alloc]init];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        WJDDemoCommonCellModel *cellModel = [[WJDDemoCommonCellModel alloc] init];
        cellModel.title = titleArray[i];
        cellModel.jumpType = WJDJumpType_AnimationCategoryDemoVC + i;
        [sectionModel.cellDatas addObject:cellModel];
    }
    [self.datas addObject:sectionModel];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.datas.count > indexPath.section && self.datas[indexPath.section].cellDatas.count > indexPath.row) {
        WJDDemoCommonCellModel *cellModel = (WJDDemoCommonCellModel *)self.datas[indexPath.section].cellDatas[indexPath.row];
        [WJDJumpManager jumpWithJumpType:cellModel.jumpType SourceVC:self Param:@{@"title" : cellModel.title}];
    }
}
@end
