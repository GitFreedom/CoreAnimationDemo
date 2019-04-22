//
//  WJDBaseCollectionReusableView.h
//  SafePartner
//
//  Created by 王俊东 on 2019/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJDBaseCollectionReusableView : UICollectionReusableView

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
