//
//  WJDBaseCollectionViewCell.h
//  SafePartner
//
//  Created by 王俊东 on 2019/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJDBaseCollectionViewCell : UICollectionViewCell

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
