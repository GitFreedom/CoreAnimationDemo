//
//  WJDBaseCollectionViewController.m
//  SafePartner
//
//  Created by 王俊东 on 2019/2/27.
//

#import "WJDBaseCollectionViewController.h"
#import "WJDDevice.h"
#import "WJDBaseSectionModel.h"
#import "WJDBaseCellModel.h"
#import "WJDBaseCollectionViewCell.h"
#import "WJDBaseCollectionReusableView.h"

@interface WJDBaseCollectionViewController ()

@end

@implementation WJDBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - delegate
#pragma mark   UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.datas.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        return self.datas[section].cellDatas.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.datas.count > indexPath.section) {
        WJDBaseSectionModel *sectionModel = self.datas[indexPath.section];
        if (sectionModel.cellDatas.count > indexPath.row) {
            WJDBaseCellModel *cellModel = sectionModel.cellDatas[indexPath.row];
            if (cellModel.className && cellModel.className.length > 0) {
                UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellModel.className forIndexPath:indexPath];
                if ([cell isKindOfClass:[WJDBaseCollectionViewCell class]]) {
                    [cell setValue:cellModel forKey:@"data"];
                    [cell setValue:self      forKey:@"delegate"];
                }
                return cell;
            }
        }
    }
    return [UICollectionViewCell new];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (self.datas.count > indexPath.section) {
        WJDBaseSectionModel *sectionModel = self.datas[indexPath.section];
        if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
            if (sectionModel.headerClassName && sectionModel.headerClassName.length > 0) {
                reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.headerClassName forIndexPath:indexPath];
            }
        }
        else if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"]) {
            if (sectionModel.footerClassName && sectionModel.footerClassName.length > 0) {
                reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.footerClassName forIndexPath:indexPath];
            }
        }
        if ([reusableView isKindOfClass:[WJDBaseCollectionReusableView class]]) {
            [reusableView setValue:sectionModel forKey:@"data"];
            [reusableView setValue:self         forKey:@"delegate"];
        }
    }
    return reusableView;
}
#pragma mark   UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.datas.count > indexPath.section) {
        WJDBaseSectionModel *sectionModel = self.datas[indexPath.section];
        if (sectionModel.cellDatas.count > indexPath.row) {
            return sectionModel.cellDatas[indexPath.row].cellSize;
        }
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        return self.datas[section].headerSize;
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    if (self.datas.count > section) {
        return self.datas[section].footerSize;
    }
    return CGSizeZero;
}
#pragma mark - getter
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing          = 0.0f;
        flowLayout.minimumInteritemSpacing     = 0.0f;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self __registerClass];
        _collectionView.delegate     = self;
        _collectionView.dataSource   = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, WJDDevice.bottomOffset, 0);
        if (WJDDevice.systemVersion >= 11.0f) {
#ifdef __IPHONE_11_0
            if (@available(iOS 11.0 ,*)) {
                _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
#endif
        }
    }
    return _collectionView;
}
- (NSMutableArray<WJDBaseSectionModel *> *)datas {
    
    if (!_datas) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}
#pragma mark - setter
//- (void)setBlankType:(WJDBlankType)blankType {
//    
//    super.blankType = blankType;
//    [self showBlankWithFrame:CGRectZero Type:blankType view:self.collectionView];
//}
#pragma mark - overWriteMethod
- (void)setupViews {
    
    CGFloat height = WJDDevice.screenHeight;
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
    self.collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
    [self.view addSubview:self.collectionView];
}
#pragma mark - PrivateMethod
- (void)__registerClass {
    
    NSArray<NSString *> *cellArray = [self collectionViewCellClassNames];
    for (NSString *cellClassName in cellArray) {
        [_collectionView registerClass:NSClassFromString(cellClassName) forCellWithReuseIdentifier:cellClassName];
    }
    NSArray<NSString *> *sectionHeaderArray = [self collectionViewSectionHeaderClassNames];
    for (NSString *sectionHeaderClassName in sectionHeaderArray) {
        [_collectionView registerClass:NSClassFromString(sectionHeaderClassName) forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:sectionHeaderClassName];
    }
    NSArray<NSString *> *sectionFooterArray = [self collectionViewSectionFooterClassNames];
    for (NSString *sectionFooterClassName in sectionFooterArray) {
        [_collectionView registerClass:NSClassFromString(sectionFooterClassName) forSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" withReuseIdentifier:sectionFooterClassName];
    }
}
#pragma mark - PublicMethod
- (NSArray<NSString *> *)collectionViewCellClassNames {
    
    return @[];
}
- (NSArray<NSString *> *)collectionViewSectionHeaderClassNames {
    
    return @[];
}
- (NSArray<NSString *> *)collectionViewSectionFooterClassNames {
    
    return @[];
}
@end
