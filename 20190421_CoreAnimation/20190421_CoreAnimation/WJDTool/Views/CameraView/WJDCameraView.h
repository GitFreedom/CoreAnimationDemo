//
//  WJDCameraView.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/11.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WJDCameraView;
typedef void(^TakePhotoComplete)(WJDCameraView *cameraView, UIImage *image);

@interface WJDCameraView : UIView
/**
 *  控制器（用来弹出授权弹框）
 */
@property (nonatomic, weak) UIViewController *targetVC;
/**
 *  是否有拍照权限
 */
@property (nonatomic, assign, readonly) BOOL haveTakePhotoAuthorization;
/**
 *  启动
 */
- (void)startCamera;
/**
 *  暂停
 */
- (void)pauseCamera;
/**
 *  拍照
 */
- (void)takePhotoWithComplete:(TakePhotoComplete)complete;
/**
 *  释放资源
 */
- (void)releaseResource;

@end

NS_ASSUME_NONNULL_END
