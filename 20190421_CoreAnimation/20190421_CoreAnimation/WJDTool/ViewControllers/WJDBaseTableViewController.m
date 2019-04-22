//
//  WJDBaseTableViewController.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/9.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDBaseTableViewController.h"

#import "WJDBaseTableViewCell.h"
#import <UIKit/UITableViewHeaderFooterView.h>
#import "WJDBaseTableViewHeaderFooterView.h"

#import "WJDBaseSectionModel.h"

#import "WJDDevice.h"

@interface WJDBaseTableViewController ()

@end

@implementation WJDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - delegate

#pragma mark   UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        return self.datas[section].cellDatas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.datas.count > indexPath.section) {
        WJDBaseSectionModel *sectionModel = self.datas[indexPath.section];
        if (sectionModel.cellDatas.count > indexPath.row) {
            WJDBaseCellModel *cellModel = sectionModel.cellDatas[indexPath.row];
            if (cellModel.className && cellModel.className.length > 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.className];
                if (!cell) {
                    Class cellClass = NSClassFromString(cellModel.className);
                    if ([[cellClass new] isKindOfClass:[UITableViewCell class]]) {
                        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellModel.className];
                    }
                    else {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellModel.className];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if ([cell isKindOfClass:[WJDBaseTableViewCell class]]) {
                    [cell setValue:cellModel forKey:@"data"];
                    [cell setValue:self forKey:@"delegate"];
                }
                return cell;
            }
        }
    }
    return [UITableViewCell new];
}

#pragma mark   UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        WJDBaseSectionModel *sectionHeaderModel = self.datas[section];
        if (sectionHeaderModel.headerClassName && sectionHeaderModel.headerClassName.length > 0) {
            UITableViewHeaderFooterView *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderModel.headerClassName];
            if (!sectionHeader) {
                Class sectionHeaderClass = NSClassFromString(sectionHeaderModel.headerClassName);
                if ([[sectionHeaderClass new] isKindOfClass:[UITableViewHeaderFooterView class]]) {
                    sectionHeader = [[sectionHeaderClass alloc]initWithReuseIdentifier:sectionHeaderModel.headerClassName];
                }
                else {
                    sectionHeader = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:sectionHeaderModel.headerClassName];
                }
            }
            if ([sectionHeader isKindOfClass:[WJDBaseTableViewHeaderFooterView class]]) {
                [sectionHeader setValue:sectionHeaderModel forKey:@"data"];
                [sectionHeader setValue:self forKey:@"delegate"];
            }
            return sectionHeader;
        }
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        WJDBaseSectionModel *sectionFooterModel = self.datas[section];
        if (sectionFooterModel.footerClassName && sectionFooterModel.footerClassName.length > 0) {
            UITableViewHeaderFooterView *sectionFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionFooterModel.footerClassName];
            if (!sectionFooter) {
                Class sectionFooterClass = NSClassFromString(sectionFooterModel.footerClassName);
                if ([[sectionFooterClass new] isKindOfClass:[UITableViewHeaderFooterView class]]) {
                    sectionFooter = [[sectionFooterClass alloc]initWithReuseIdentifier:sectionFooterModel.footerClassName];
                }
                else {
                    sectionFooter = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:sectionFooterModel.footerClassName];
                }
            }
            if ([sectionFooter isKindOfClass:[WJDBaseTableViewHeaderFooterView class]]) {
                [sectionFooter setValue:sectionFooterModel forKey:@"data"];
                [sectionFooter setValue:self forKey:@"delegate"];
            }
            return sectionFooter;
        }
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.datas.count > indexPath.section) {
        WJDBaseSectionModel *sectionModel = self.datas[indexPath.section];
        if (sectionModel.cellDatas.count > indexPath.row) {
            return sectionModel.cellDatas[indexPath.row].cellHeight;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        return self.datas[section].headerHeight;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        return self.datas[section].footerHeight;
    }
    return CGFLOAT_MIN;
}

#pragma mark - Getter

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, WJDDevice.bottomOffset, 0);
        if (WJDDevice.systemVersion >= 11.0f) {
#ifdef __IPHONE_11_0
            if (@available(iOS 11.0 ,*)) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
#endif
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray<WJDBaseSectionModel *> *)datas {
    
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}

#pragma mark - Setter

//- (void)setBlankType:(WJDBlankType)blankType {
//    
//    super.blankType = blankType;
//    [self showBlankWithFrame:CGRectZero Type:blankType view:self.tableView];
//}

#pragma mark - OverWriteMethod

- (void)setupViews {
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (self.navigationStatus != NavigationStatus_hidden) {
        height -= ([WJDDevice statusBarHeight] + 44);
    }
    if (self.tabbarStatus != TabbarStatus_hidden) {
        if (self.tabbarStatus == TabbarStatus_show) {
            height -= ([WJDDevice bottomOffset] + 49);
        }
        else {
            if (self.navigationController.viewControllers.count <= 1) {
                height -= ([WJDDevice bottomOffset] + 49);
            }
        }
    }
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
    [self.view addSubview:self.tableView];
}

@end
