//
//  QTMobileLiveManager.h
//  QTLive
//
//  Created by 张亚超 on 2019/11/20.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JXRecorderEnum.h"
#import "JXRecoderMainDefine.h"

#import "QTMobileAnchorLiveEffectView.h"


/**
 移动主播端直播管理
 */
@interface QTMobileLiveManager : NSObject

+ (instancetype)shareInstance;

/**
 获取录制的视图
 @param frame frame description
 @return return value description
 */

+ (UIView *)startRecorderPreviewViewWithFrame:(CGRect)frame;


//开始直播
+ (void)startLiveWithPushStreamUrl:(NSString *)pushStreamUrl;


/** 暂停直播 */
+ (void)pauseLive;

/**
 继续直播
 */
+ (void)resumeLive;

/**
 停止直播
 */
+ (void)stopLive;

/** 重新开始直播 */
+ (void)restartLive;



/** 切换摄像头 */
+ (void)switchCameraDirection;


/** 修改闪光灯模式 */
+ (void)changeFlashMode;


#pragma mark - 美颜操作
/**
 设置美颜等级
 
 @param level level description

 */
+ (void)configBeautifyLevel:(float)level;

/**
 设置大眼等级
 
 @param level <#level description#>
 */
+ (void)configEnlargeEyeLevel:(float)level;

/**
 设置瘦脸等级
 
 @param level <#level description#>
 */
+ (void)configShrinkFaceLevel:(float)level;

/**
 设置磨皮
 
 @param level 磨皮级别[0 ,1.0]
 */
+ (void)configSmoothStrength:(float)level;

/**
 设置滤镜
 
 @param filterName 滤镜名称
 @param filterLev 滤镜成都
 */
+ (void)configFilterName:(NSString *)filterName filterLev:(float)filterLev;


/**
 配置是否使用贴纸
 
 @param enableSticker 是否使用
 */
+ (void)configEnableSticker:(BOOL)enableSticker;


/**
 设置需要改变的贴纸
 
 @param stickerTitle <#stickerTitle description#>
 */
+ (void)configNeedChangedSticker:(NSString *)stickerTitle;
#pragma mark - Other
//
+ (QTMobileAnchorLiveEffectView *)fetchRecorderEffectView;

/**
 销毁播放器
 */
+ (void)destory;

/// 录制器的日志模式
/// @param logMode logMode description
+ (void)configRecorderLogMode:(BOOL)logMode;

/// 录制器日志路径
+ (NSArray *)recorderLogPaths;


@end
