//
//  WJDDevice.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDDevice.h"
#import <sys/utsname.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIScreen.h>
#import <UIKit/UIApplication.h>

@interface WJDDevice () {
    NSString *__appVersion;
    NSString *__appName;
    NSString *__appBuildInfo;
    NSString *__targetName;
    NSString *__bundleId;
    NSString *__deviceOS;
    NSString *__deviceModel;
    NSString *__deviceName;
    double __systemVersion;
    double __statusBarHeight;
    double __bottomOffset;
    CGSize __screenSize;
    WJDScreenSizeType __screenSizeType;
}

@end

@implementation WJDDevice

Singleton_imp(WJDDevice)

/**
 *  @brief:app版本
 */
+ (nonnull NSString *)getAppVersion {
    
    if (![WJDDevice shareInstance]->__appVersion) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        [WJDDevice shareInstance]->__appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return [WJDDevice shareInstance]->__appVersion;
}

/**
 *  @brief:app名字
 */
+ (nonnull NSString *)getAppName {
    
    if (![WJDDevice shareInstance]->__appName) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        if ([infoDictionary objectForKey:@"CFBundleDisplayName"]) {
            [WJDDevice shareInstance]->__appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        }
        else {
            [WJDDevice shareInstance]->__appName = [infoDictionary objectForKey:@"CFBundleName"];
        }
    }
    return [WJDDevice shareInstance]->__appName;
    
}


/**
 *  @brief:app构建版本
 */
+ (nonnull NSString *)getAppBuildInfo {
    
    if (![WJDDevice shareInstance]->__appBuildInfo) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        [WJDDevice shareInstance]->__appBuildInfo = [infoDictionary objectForKey:@"CFBundleVersion"];
    }
    return [WJDDevice shareInstance]->__appBuildInfo;
}


/**
 *  @brief:app版本target的名字
 */
+ (nonnull NSString *)getExecuteName {
    
    if (![WJDDevice shareInstance]->__targetName) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        [WJDDevice shareInstance]->__targetName = [infoDictionary objectForKey:@"CFBundleExecutable"];
    }
    return [WJDDevice shareInstance]->__targetName;
}


/**
 *  @brief:appbundle的信息
 */
+ (nonnull NSString *)getBundleId {
    
    if (![WJDDevice shareInstance]->__bundleId) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        [WJDDevice shareInstance]->__bundleId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    }
    return [WJDDevice shareInstance]->__bundleId;
}


/**
 *  @brief:设备相关,取设备os信息，return sample: iOS7.1
 */
+ (nonnull NSString *)getDeviceOS {
    
    if (![WJDDevice shareInstance]->__deviceOS) {
        UIDevice *device = [UIDevice currentDevice];
        [WJDDevice shareInstance]->__deviceOS = [NSString stringWithFormat:@"%@%@",device.systemName,device.systemVersion];
    }
    
    return [WJDDevice shareInstance]->__deviceOS;
}


/**
 *  @brief:设备相关,取设备信息，return sample :iPhone5,1
 */
+ (nonnull NSString *)getDeviceModel {
    
    if (![WJDDevice shareInstance]->__deviceModel) {
        struct utsname systemInfo;
        uname(&systemInfo);
        [WJDDevice shareInstance]->__deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    
    return [WJDDevice shareInstance]->__deviceModel;
}

/**
 *  @brief:设备相关,取设备名称，return sample :iPhoneX
 */
+ (nonnull NSString *)getDeviceName {
    
    if (![WJDDevice shareInstance]->__deviceName) {
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceName = [NSString stringWithCString:systemInfo.machine
                                                  encoding:NSUTF8StringEncoding];
        if ([deviceName isEqualToString:@"i386"]) {
            deviceName = @"Simulator";
        } else if ([deviceName isEqualToString:@"x86_64"]) {
            deviceName = @"Simulator";
        } else if ([deviceName isEqualToString:@"iPhone1,1"]) {
            deviceName = @"";
        } else if ([deviceName isEqualToString:@"iPhone1,2"]) {
            deviceName = @"iPhone3G";
        } else if ([deviceName isEqualToString:@"iPhone2,1"]) {
            deviceName = @"iPhone3GS";
        } else if ([deviceName isEqualToString:@"iPhone3,1"]) {
            deviceName = @"iPhone4";
        } else if ([deviceName isEqualToString:@"iPhone3,2"]) {
            deviceName = @"iPhone4";
        } else if ([deviceName isEqualToString:@"iPhone4,1"]) {
            deviceName = @"iPhone4s";
        } else if ([deviceName isEqualToString:@"iPhone5,1"]) {
            deviceName = @"iPhone5";
        } else if ([deviceName isEqualToString:@"iPhone5,2"]) {
            deviceName = @"iPhone5";
        } else if ([deviceName isEqualToString:@"iPhone5,3"]) {
            deviceName = @"iPhone5c";
        } else if ([deviceName isEqualToString:@"iPhone5,4"]) {
            deviceName = @"iPhone5c";
        } else if ([deviceName isEqualToString:@"iPhone6,1"]) {
            deviceName = @"iPhone5s";
        } else if ([deviceName isEqualToString:@"iPhone6,2"]) {
            deviceName = @"iPhone5s";
        } else if ([deviceName isEqualToString:@"iPhone7,1"]) {
            deviceName = @"iPhone6Plus";
        } else if ([deviceName isEqualToString:@"iPhone7,2"]) {
            deviceName = @"iPhone6";
        } else if ([deviceName isEqualToString:@"iPhone8,1"]) {
            deviceName = @"iPhone6s";
        } else if ([deviceName isEqualToString:@"iPhone8,2"]) {
            deviceName = @"iPhone6sPlus";
        } else if ([deviceName isEqualToString:@"iPhone8,4"]) {
            deviceName = @"iPhoneSE";
        } else if ([deviceName isEqualToString:@"iPhone9,1"]) {
            deviceName = @"iPhone7";
        } else if ([deviceName isEqualToString:@"iPhone9,3"]) {
            deviceName = @"iPhone7";
        } else if ([deviceName isEqualToString:@"iPhone9,2"]) {
            deviceName = @"iPhone7Plus";
        } else if ([deviceName isEqualToString:@"iPhone9,4"]) {
            deviceName = @"iPhone7Plus";
        } else if ([deviceName isEqualToString:@"iPhone10,1"]) {
            deviceName = @"iPhone8";
        } else if ([deviceName isEqualToString:@"iPhone10,4"]) {
            deviceName = @"iPhone8";
        } else if ([deviceName isEqualToString:@"iPhone10,2"]) {
            deviceName = @"iPhone8Plus";
        } else if ([deviceName isEqualToString:@"iPhone10,5"]) {
            deviceName = @"iPhone8Plus";
        } else if ([deviceName isEqualToString:@"iPhone10,3"]) {
            deviceName = @"iPhoneX";
        } else if ([deviceName isEqualToString:@"iPhone10,6"]) {
            deviceName = @"iPhoneX";
        }
        [WJDDevice shareInstance]->__deviceName = deviceName;
    }
    return [WJDDevice shareInstance]->__deviceName;
}

/**
 *  @brief:系统版本
 */
+ (CGFloat)systemVersion {
    
    if ([WJDDevice shareInstance]->__systemVersion == 0) {
        UIDevice *device = [UIDevice currentDevice];
        [WJDDevice shareInstance]->__systemVersion = [device.systemVersion doubleValue];
    }
    return [WJDDevice shareInstance]->__systemVersion;
}

/**
 *  @brief:返回状态栏的高度(竖屏的)
 *  @return:返回高度
 */
+ (CGFloat)statusBarHeight {
    
    if ([WJDDevice shareInstance]->__statusBarHeight == 0) {
        [WJDDevice shareInstance]->__statusBarHeight = [WJDDevice getScreenSize] >= ScreenSizeType_5_8_inch ? 44.0f : 20.0f;
    }
    return [WJDDevice shareInstance]->__statusBarHeight;
}

/**
 *  @brief: 获取屏幕尺寸
 */
+ (WJDScreenSizeType)getScreenSize {
    
    if ([WJDDevice shareInstance]->__screenSizeType == ScreenSizeType_unknow) {
        WJDScreenSizeType screenSizeType = ScreenSizeType_unknow;
        unsigned short screenWidth  = (unsigned short)CGRectGetWidth([UIScreen mainScreen].bounds);
        unsigned short screenHeight = (unsigned short)CGRectGetHeight([UIScreen mainScreen].bounds);
        switch (screenWidth) {
            case 320: {
                switch (screenHeight) {
                    case 480: {
                        screenSizeType = ScreenSizeType_3_5_inch;
                    }
                        break;
                    case 568: {
                        screenSizeType = ScreenSizeType_4_0_inch;
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case 375: {
                switch (screenHeight) {
                    case 667: {
                        screenSizeType = ScreenSizeType_4_7_inch;
                    }
                        break;
                    case 812: {
                        screenSizeType = ScreenSizeType_5_8_inch;
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case 414: {
                switch (screenHeight) {
                    case 736: {
                        screenSizeType = ScreenSizeType_5_5_inch;
                    }
                        break;
                    case 896: {
                        screenSizeType = [UIScreen mainScreen].scale == 2 ? ScreenSizeType_6_1_inch : ScreenSizeType_6_5_inch;
                    }
                        break;
                    default:
                        break;
                }
                
            }
                break;
            default:
                break;
        }
        [WJDDevice shareInstance]->__screenSizeType = screenSizeType;
    }
    
    return [WJDDevice shareInstance]->__screenSizeType;
}
/**
 *  @brief : bottom offset
 */
+ (CGFloat)bottomOffset {
    
    return [WJDDevice getScreenSize] >= ScreenSizeType_5_8_inch ? 34.0f : 0.0f;
}

/**
 *  @brief : screenSize
 */
+ (CGSize)screenSize {
    
    if (CGSizeEqualToSize([WJDDevice shareInstance]->__screenSize, CGSizeZero)) {
        [WJDDevice shareInstance]->__screenSize = [UIScreen mainScreen].bounds.size;
    }
    return [WJDDevice shareInstance]->__screenSize;
}

/**
 *  @brief : screenWidth
 */
+ (CGFloat)screenWidth {
    
    return WJDDevice.screenSize.width;
}

/**
 *  @brief : screenHeight
 */
+ (CGFloat)screenHeight {
    
    return WJDDevice.screenSize.height;
}

/**
 *  @brief : isHorizontalScreen 是否是横屏
 */
+ (BOOL)isHorizontalScreen {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (screenSize.width > screenSize.height) {
        return YES;
    }
    return NO;
}

/**
 *  @brief: 打开app
 */
+ (void)openAppWithAppId:(nonnull NSString *)appid {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://",appid]];
    
    //先判断是否能打开该url
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        //打开url
        [[UIApplication sharedApplication] openURL:url];
    } else {
        //给个提示或者做点别的事情
        NSLog(@"******没安装该app！******");
    }
}

@end
