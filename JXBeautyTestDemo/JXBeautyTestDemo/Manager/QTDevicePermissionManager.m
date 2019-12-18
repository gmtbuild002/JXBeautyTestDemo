//
//  QTDevicePermissionManager.m
//  QTLive
//
//  Created by 张亚超 on 2019/11/26.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import "QTDevicePermissionManager.h"
#import <AVFoundation/AVFoundation.h>

@interface QTDevicePermissionManager ()

@end
@implementation QTDevicePermissionManager


//- (void)dealAlertSetPermission
//{
//    [self.openLiveAlertView dismissWithClickedButtonIndex:0 animated:NO];
//    if([[self class] canOpenAppPermissionSetting])
//    {
//        self.openLiveAlertView = [UIAlertView showWithTitle:@"开播需要您开启以下权限" message:@"麦克风\n摄像头" cancelButtonTitle:@"取消" otherButtonTitles:@[@"设置"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            if (buttonIndex == 1) {
//
//                [[self class] jumpToAppSetting];
//
//            }else{
//
//            }
//        }];
//    }
//    else
//    {
//         self.openLiveAlertView = [UIAlertView showWithTitle:@"开播需要您开启以下权限" message:@"麦克风\n摄像头" cancelButtonTitle:@"取消" otherButtonTitles:@[@"设置"] tapBlock:nil];
//    }
//}
//
//


//获取照相机权限
+ (void)checkCamarePermissionWithHandler:(QTDevicePermissionBlock)handler
{
    if ([self checkVideoCaptureDevice] == NO) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(handler)
            {
                handler(NO,NO);
            }
        });
    }
    else{
        [self checkDevicePermissionWithMediaType:AVMediaTypeVideo handler:handler];
        
    }
}
+ (void)checkMicphonePermissionWithHandler:(QTDevicePermissionBlock)handler
{
    [self checkDevicePermissionWithMediaType:AVMediaTypeAudio handler:handler];
    
}
//
//
//+ (BOOL)canOpenAppPermissionSetting
//{
//    if(iOS8)
//    {
//        NSURL*url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if([[UIApplication sharedApplication] canOpenURL:url]) {
//
//            return YES;
//        }
//    }
//
//    return NO;
//}

//+ (void)jumpToAppSetting
//{
//    if(iOS8)
//    {
//        NSURL*url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if([[UIApplication sharedApplication] canOpenURL:url]) {
//
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }
//}
#pragma mark - Private Function
+ (BOOL)checkVideoCaptureDevice{
#if !TARGET_IPHONE_SIMULATOR
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if (devices.count == 0) {
        return NO;
    }else{
        return YES;
    }
#else
    return YES;
#endif
}
+ (void)checkDevicePermissionWithMediaType:(AVMediaType)mediaType
                                   handler:(QTDevicePermissionBlock)handler
{
    

    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
       //还未访问过
       if(authorizationStatus == AVAuthorizationStatusNotDetermined)
       {
           //请求视频采集权限
           [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   if(handler)
                   {
                       handler(YES,granted);
                   }
                   
               });
           }];

       }else if (authorizationStatus == AVAuthorizationStatusRestricted ||
                 authorizationStatus == AVAuthorizationStatusDenied)
       {
           //
           if(handler)
           {
               handler(NO,NO);
           }
           
       }else{
           
           if(handler)
           {
               handler(NO,YES);
           }
           
       }
    
    
}
@end
