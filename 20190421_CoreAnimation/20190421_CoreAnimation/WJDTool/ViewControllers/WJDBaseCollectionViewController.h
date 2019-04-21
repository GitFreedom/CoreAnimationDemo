//
//  WJDBaseCollectionViewController.h
//  SafePartner
//
//  Created by 王俊东 on 2019/2/27.
//

#import "WJDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class WJDBaseSectionModel;
@interface WJDBaseCollectionViewController : WJDBaseViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 *  CollectionView
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  数据
 */
@property (nonatomic, strong) NSMutableArray<WJDBaseSectionModel*> *datas;

- (NSArray<NSString *>*)collectionViewCellClassNames;

- (NSArray<NSString *>*)collectionViewSectionHeaderClassNames;

- (NSArray<NSString *>*)collectionViewSectionFooterClassNames;

@end

NS_ASSUME_NONNULL_END
