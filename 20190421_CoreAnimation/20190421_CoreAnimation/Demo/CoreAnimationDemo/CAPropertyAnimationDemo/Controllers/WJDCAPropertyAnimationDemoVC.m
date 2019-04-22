//
//  WJDCAPropertyAnimationDemoVC.m
//  20190421_CoreAnimation
//
//  Created by 王俊东 on 2019/4/22.
//  Copyright © 2019 王俊东. All rights reserved.
//

#import "WJDCAPropertyAnimationDemoVC.h"

#import "WJDDemoCommonCellModel.h"

@interface WJDCAPropertyAnimationDemoVC ()

@end

@implementation WJDCAPropertyAnimationDemoVC

- (void)viewDidLoad {
    self.tabbarStatus = TabbarStatus_hidden;
    [super viewDidLoad];
    
    [self _configInit];
}

#pragma mark - Private

- (void)_configInit {
    
    NSArray *titleArray = @[@"基础动画",@"关键帧动画"];
    WJDBaseSectionModel *sectionModel = [[WJDBaseSectionModel alloc]init];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        WJDDemoCommonCellModel *cellModel = [[WJDDemoCommonCellModel alloc] init];
        cellModel.title = titleArray[i];
        cellModel.jumpType = WJDJumpType_CABasicAnimationDemoVC + i;
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
