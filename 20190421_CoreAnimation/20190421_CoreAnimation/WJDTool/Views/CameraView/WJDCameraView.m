//
//  WJDCameraView.m
//  WJDToolProject
//
//  Created by 王俊东 on 2019/1/11.
//  Copyright © 2019年 www.wangjundong.com. All rights reserved.
//

#import "WJDCameraView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+WJDAdd.h"

@interface WJDCameraView ()

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;//预览图层，来显示照相机拍摄到的画面
//视频流相关
@property (nonatomic, strong) AVCaptureSession *session;//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;//AVCaptureDeviceInput对象是输入流

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;// 照片输出流对象
#pragma clang diagnostic pop
//授权状态
@property (nonatomic, assign) AVAuthorizationStatus authorizationStatus;
//队列
@property (nonatomic) dispatch_queue_t sessionQueue;
//是否已添加预览图层
@property (nonatomic, assign) BOOL alreadyAddPreviewLayer;
@end

@implementation WJDCameraView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //初始化
        self.sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
        self.session = [[AVCaptureSession alloc] init];
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(self.frame.size, self.previewLayer.frame.size)) {
        self.previewLayer.frame = self.bounds;
        [self.previewLayer removeFromSuperlayer];
        [self.layer addSublayer:self.previewLayer];
    }
}

#pragma mark - PrivateMethod

// 获取前后摄像头对象的方法
- (AVCaptureDevice *)__cameraWithPosition:(AVCaptureDevicePosition)position {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
#pragma clang diagnostic pop
    for (AVCaptureDevice *captureDevice in devices) {
        
        if (captureDevice.position == position) {
            
            return captureDevice;
        }
    }
    return nil;
}

- (void)__configureSession {
    
    if (self.authorizationStatus != AVAuthorizationStatusAuthorized) {
        return;
    }
    [self.session beginConfiguration];//保证对AVCaptureSession设置的原子性与commitConfiguration配对使用
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self __cameraWithPosition:AVCaptureDevicePositionFront] error:nil];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    // 输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,@(0.1),AVVideoQualityKey,nil];
#pragma clang diagnostic pop
    
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    [self.session commitConfiguration];
}

- (void)__requestAuthorization {
    
    self.authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (self.authorizationStatus) {
        case AVAuthorizationStatusAuthorized: {
            dispatch_async(self.sessionQueue, ^{
                [self __configureSession];
                [self.session startRunning];
            });
            break;
        }
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^( BOOL granted ) {
                if ( granted ) {
                    self.authorizationStatus = AVAuthorizationStatusAuthorized;
                    [self __configureSession];
                    [self.session startRunning];
                }
            }];
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted: {
            NSString *message = @"没有拍照权限，所以不能拍摄头像";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self.targetVC presentViewController:alertController animated:YES completion:nil];
            break;
        }
            break;
        default:
            break;
    }
}

#pragma mark - PublicMethod

- (void)startCamera {
    
    if (self.authorizationStatus != AVAuthorizationStatusAuthorized) {
        [self __requestAuthorization];
    } else {
        dispatch_async(self.sessionQueue, ^{
            [self.session startRunning];
        });
    }
}

- (void)pauseCamera {
    
    [self.session stopRunning];
}

- (void)takePhotoWithComplete:(TakePhotoComplete)complete {
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.sessionQueue, ^{
        AVCaptureConnection *videoConnection = [weakSelf.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
        if (!videoConnection) {
            return;
        }
        [weakSelf.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
            
            if (imageDataSampleBuffer == NULL) {
                return;
            }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
#pragma clang diagnostic pop
            UIImage *originalImage = [UIImage imageWithData:imageData];
            originalImage = [originalImage fixOrientation];
            if (complete) {
                complete(weakSelf,originalImage);
            }
        }];
    });
}

- (void)releaseResource {
    
    dispatch_async(self.sessionQueue, ^{
        if ( self.authorizationStatus == AVAuthorizationStatusAuthorized ) {
            [self.session stopRunning];
        }
        self.session = nil;
        self.videoInput = nil;
        self.stillImageOutput = nil;
    });
}

- (BOOL)haveTakePhotoAuthorization {
    
    return self.authorizationStatus == AVAuthorizationStatusAuthorized;
}

#pragma mark - System

- (void)dealloc {
    
    NSLog(@"WJDCameraView delloc");
}

@end
