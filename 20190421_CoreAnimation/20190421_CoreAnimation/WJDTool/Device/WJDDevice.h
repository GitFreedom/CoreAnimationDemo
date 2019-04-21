//
//  WJDDevice.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <CoreGraphics/CGGeometry.h>
#import "WJDDeviceCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface WJDDevice : NSObject

/**
 *  @brief:app版本
 */
+ (nonnull NSString *)getAppVersion;

/**
 *  @brief:app名字
 */
+ (nonnull NSString *)getAppName;

/**
 *  @brief:app构建版本
 */
+ (nonnull NSString *)getAppBuildInfo;

/**
 *  @brief:app版本target的名字
 */
+ (nonnull NSString *)getExecuteName;

/**
 *  @brief:appbundle的信息
 */
+ (nonnull NSString *)getBundleId;

/**
 *  @brief:设备相关,取设备os信息(系统版本)，return sample: iOS11.4
 */
+ (nonnull NSString *)getDeviceOS;

/**
 *  @brief:设备相关,取设备信息，return sample :iPhone5,1
 */
+ (nonnull NSString *)getDeviceModel;

/**
 *  @brief:设备相关,取设备名称，return sample :iPhoneX
 */
+ (nonnull NSString *)getDeviceName;

/**
 *  @brief:系统版本, return sample: 11.4
 */
+ (CGFloat)systemVersion;

/**
 *  @brief:返回状态栏的高度(竖屏的)
 *  @return:返回高度
 */
+ (CGFloat)statusBarHeight;

/**
 *  @brief: 获取屏幕尺寸
 */
+ (WJDScreenSizeType)getScreenSize;

/**
 *  @brief : bottom offset
 */
+ (CGFloat)bottomOffset;

/**
 *  @brief : screenSize
 */
+ (CGSize)screenSize;

/**
 *  @brief : screenWidth
 */
+ (CGFloat)screenWidth;

/**
 *  @brief : screenHeight
 */
+ (CGFloat)screenHeight;

/**
 *  @brief : isHorizontalScreen 是否是横屏
 */
+ (BOOL)isHorizontalScreen;

/**
 *  @brief: 打开app
 */
+ (void)openAppWithAppId:(nonnull NSString *)appid;

@end

NS_ASSUME_NONNULL_END
