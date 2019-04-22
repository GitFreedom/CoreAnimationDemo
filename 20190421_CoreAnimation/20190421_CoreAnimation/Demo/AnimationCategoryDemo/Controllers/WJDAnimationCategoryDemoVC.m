//
//  WJDAnimationCategoryDemoVC.m
//  20190421_CoreAnimation
//
//  Created by 王俊东 on 2019/4/21.
//  Copyright © 2019 王俊东. All rights reserved.
//

#import "WJDAnimationCategoryDemoVC.h"

#import "WJDDemoCommonCellModel.h"

@interface WJDAnimationCategoryDemoVC ()

@end

@implementation WJDAnimationCategoryDemoVC

- (void)viewDidLoad {
    self.tabbarStatus = TabbarStatus_hidden;
    [super viewDidLoad];
    
    [self _configInit];
}

#pragma mark - Private

- (void)_configInit {
    
    NSArray *titleArray = @[@"UIView的Block分类",@"UIView的关键帧分类"];
    WJDBaseSectionModel *sectionModel = [[WJDBaseSectionModel alloc]init];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        WJDDemoCommonCellModel *cellModel = [[WJDDemoCommonCellModel alloc] init];
        cellModel.title = titleArray[i];
        cellModel.jumpType = WJDJumpType_AnimationWithBlockDemoVC + i;
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
