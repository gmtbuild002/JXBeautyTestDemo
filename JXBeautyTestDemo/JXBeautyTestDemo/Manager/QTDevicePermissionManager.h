//
//  QTDevicePermissionManager.h
//  QTLive
//
//  Created by 张亚超 on 2019/11/26.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^QTDevicePermissionBlock) (BOOL firstDetermine,BOOL granted);

NS_ASSUME_NONNULL_BEGIN

@interface QTDevicePermissionManager : NSObject


/// 麦克风的权限访问
/// @param handler <#handler description#>
+ (void)checkMicphonePermissionWithHandler:(QTDevicePermissionBlock)handler;

/// 照相机的权限访问
/// @param handler <#handler description#>
+ (void)checkCamarePermissionWithHandler:(QTDevicePermissionBlock)handler;

@end

NS_ASSUME_NONNULL_END
