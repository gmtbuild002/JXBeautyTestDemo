//
//  JXMediaRecorderController.h
//  JXPlayer
//
//  Created by 张亚超 on 2019/8/1.
//  Copyright © 2019 zhangyachao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JXRecorderEnum.h"
#import "JXRecoderMainDefine.h"

@protocol JXMediaRecorderControllerDelegate;
@protocol JXMediaRecorderControllerCaptureDelegate;

@interface JXMediaRecorderController : NSObject

/** 播放器是否处于推流状态*/
@property (nonatomic, assign ,readonly) BOOL isLiving;

@property (nonatomic, weak) id <JXMediaRecorderControllerDelegate> _Nullable  delegate;
@property (nonatomic, weak) id <JXMediaRecorderControllerCaptureDelegate> _Nullable  captureDelegate;

//获取播放的总时长 单位 ：秒（s）（音乐时长）
@property (nonatomic,assign,readonly)float duration;
//获取当前时间进度 单位：秒（播放音乐的进度）
@property (nonatomic,assign,readonly)float currentTime;

/**
 开始直播
 @param pushStreamUrl 推流地址
 */
- (void)startMobileLiveWithPushStreamUrl:(NSString *_Nullable)pushStreamUrl;



/**
 *  重新开播
 */
- (void)restartOpenLiveWithPushStreamUrl:(NSString *_Nullable)pushStreamUrl;

/**
 获取视频视图
 @param frame frame
 @return return value description
 */
- (UIView *_Nullable)startVideoPreviewWithFrame:(CGRect)frame;

/**
 *  暂停当前开播
 */
- (void)pauseLive;

/**
 继续录制
 */
- (void)resumeLive;

/**
 *  停止录制
 */
- (void)stopLive;

/**
 结束推流，不结束渲染预览
 */
- (void)endPushStream;

/**
 *  销毁
 */
- (void)destory;

/**
 改变摄像头方向
 */
- (void)switchCameraDirection;

/**
 *  手电筒（默认关,代替闪光灯）
 */
- (void)changeFlashMode;

/// 镜像
/// @param mirror <#mirror description#>
- (void)configMirror:(BOOL)mirror;
/**
 重推次数。default 3
 @param repushCount repushCount description
 */
//- (void)configRepushCount:(NSInteger)repushCount;
/**
 播放伴奏和原声
 
 @param musicPath 音频伴奏
 @param orgSongPath 音频原声
 */
- (void)playMusicWithPath:(NSString *_Nullable)musicPath orgSongPath:(NSString*_Nullable)orgSongPath;

/**
 切换原声
 @param orgSong 是否是原声
 */
- (void)switchOrgSong:(BOOL)orgSong;

/**
 停止播放音频
 */
- (void)stopPlayMusic;

/**
 暂停播放音频
 */
- (void)pausePlayMusic;

/**
 继续播放音频
 */
- (void)resumePlayMusic;

/**
 录制的人声
 @param recordVolume recordVolume description
 */
- (void)configRecorderVolume:(float)recordVolume;

/**
 音乐伴奏的声音
 @param playVolume playVolume description
 */
- (void)configPlayMusicVolume:(float)playVolume;

/**
 开启日志
 */
- (void)configRecorderLogMode:(BOOL)openLogMode;
//日志路径
- (NSArray *_Nullable)recorderLogPaths;

@end


@protocol JXMediaRecorderControllerDelegate<NSObject>

@optional

/**
 录制器直播过程中状态回调
 
 @param status 状态
 @param liveError 错误
 @param recorderController recorderController description
 */
- (void)jx_newRecorderControllerLiveStatusChanged:(JXRecorderControllerLiveStatus)status
                                     liveError:(NSError *_Nullable)liveError
                            recorderController:(JXMediaRecorderController *_Nullable)recorderController;

/**
 音乐播放状态回调
 @param status 状态
 @param recorderController recorderController description
 */
- (void)jx_newRecorderControllerPlayMusicStatusChanged:(JXRecorderMusicStatus)status
                                 recorderController:(JXMediaRecorderController *_Nullable)recorderController;


@end

@protocol JXMediaRecorderControllerCaptureDelegate<NSObject>

@optional

- (void)internalCaptureSampleBufferCallback:(CMSampleBufferRef _Nonnull  _Nonnull )sampleBuffer
                         recorderController:(JXMediaRecorderController *_Nullable)recorderController;


@end
