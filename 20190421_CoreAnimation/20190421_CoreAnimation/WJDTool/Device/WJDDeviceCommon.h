//
//  WJDDeviceCommon.h
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/8.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#ifndef WJDDeviceCommon_h
#define WJDDeviceCommon_h

typedef NS_ENUM(NSInteger, WJDScreenSizeType) {
    ScreenSizeType_unknow = 0,
    ScreenSizeType_3_5_inch,
    ScreenSizeType_4_0_inch,
    ScreenSizeType_4_7_inch,
    ScreenSizeType_5_5_inch,
    ScreenSizeType_5_8_inch,
    ScreenSizeType_6_1_inch,
    ScreenSizeType_6_5_inch,
};



#define Singleton_del(_type_)\
+ (_type_ *)shareInstance;\
+ (instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+ (instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
- (instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
- (instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));\

#define Singleton_imp(_type_)\
+ (_type_ *)shareInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super allocWithZone:nil] init];\
});\
return theSharedInstance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
return [_type_ shareInstance];\
}\
- (instancetype)copyWithZone:(NSZone *)zone {\
return [_type_ shareInstance];\
}\
- (instancetype)mutableCopyWIthZone:(NSZone *)zone {\
return [_type_ shareInstance];\
}\

#endif /* WJDDeviceCommon_h */
