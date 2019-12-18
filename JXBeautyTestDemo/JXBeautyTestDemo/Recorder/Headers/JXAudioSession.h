//
//  KGAVAudioSession.h
//  AVAudioSessionNotificationCenter
//
//  Created by g on 10/28/14.
//  Copyright (c) 2014 g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define JXAudioSessionInterruptionOptionKey @"audio_session_interruption_option_key"
#define JXAudioSessionInterruptionTypeKey   @"audio_session_interruption_tyep_key"
#define JXAudioSessionInterruptionWasSuspendedKey   @"audio_session_interruption_wassuspended_Key"

//
#define JXAudioSessionRouteChangeReasonKey  @"audio_session_route_change_reason_key"
#define JXAudioSessionRouteChangePreviousRouteKey @"audio_session_route_change_previous_route_key"
#define KGAVAudioSessionRouteChangeCurrentRouteKey @"audio_session_route_change_current_route_key"

#define JXAudioSessionCategoryAmbient       @"AVAudioSessionCategoryAmbient"
#define JXAudioSessionCategorySoloAmbient   @"AVAudioSessionCategorySoloAmbient"
#define JXAudioSessionCategoryPlayback      @"AVAudioSessionCategoryPlayback"
#define JXAudioSessionCategoryRecord        @"AVAudioSessionCategoryRecord"
#define JXAudioSessionCategoryPlayAndRecord @"AVAudioSessionCategoryPlayAndRecord"
#define JXAudioSessionCategoryAudioProcessing @"AVAudioSessionCategoryAudioProcessing"
#define JXAudioSessionCategoryMultiRoute    @"AVAudioSessionCategoryMultiRoute"


typedef NS_ENUM(NSInteger ,JXAudioSessionSetActiveOptions)
{
    //通知中断的应用程序中断已结束并且可以恢复播放
    JXAudioSessionSetActiveOptionNotifyOthersOnDeactivation
    
};

//监听的事件
typedef NS_ENUM(NSInteger ,JXAudioSessionEvent)
{
    JXAudioSessionEventRouteChange = 1,     //播放设备改变
    JXAudioSessionEventInterruption = 2     //打断时间
};



//会话七个场景下 可设置的选项
typedef NS_ENUM(NSInteger ,JXAudioSessionCategoryOptions)
{
    JXAudioSessionCategoryOptionMixWithOthers  = 1,     //是否可以和其他后台App进行混音
    JXAudioSessionCategoryOptionDuckOthers  = 2,        //是否压低其他App声音
    JXAudioSessionCategoryOptionAllowBluetooth  = 4,    //是否支持蓝牙耳机
    JXAudioSessionCategoryOptionDefaultToSpeaker  = 8    //是否默认用免提声音
    
};

//播放端口改变原因
typedef NS_ENUM(NSInteger ,JXAudioSessionRouteChangeReason)
{
    JXAudioSessionRouteChangeReasonNewDeviceAvailable  = 1,//On headphone plugging in
    JXAudioSessionRouteChangeReasonOldDeviceUnavailable  = 2,//on headphone unplugging
};
//打断类型
typedef NS_ENUM(NSInteger ,JXAudioSessionInterruptionType)
{
    JXAudioSessionInterruptionTypeBegan  = 1,
    JXAudioSessionInterruptionTypeEnded  = 0,
};

@interface JXAudioSession : NSObject

//
+(JXAudioSession*) sharedSession;
//
- (BOOL)setActive:(BOOL)beActive
            error:(NSError **)outError;
//
- (BOOL)setActive:(BOOL)active
      withOptions:(JXAudioSessionSetActiveOptions)options
            error:(NSError **)outError;
//设置音频会话场景
- (BOOL)setCategory:(NSString *)theCategory
              error:(NSError **)outError;

//设置音频会话场景 和 选项
- (BOOL)setCategory:(NSString *)category
        withOptions:(JXAudioSessionCategoryOptions)options
              error:(NSError **)outError;

//获取当前设置的场景
- (NSString*) category;

/**
 是否插入耳机状态
 @return return value description
 */
- (BOOL) isHeadphoneInUse;

/**
 设置输出端口

 @param portOverride <#portOverride description#>
 */
- (void)setoverrideOutputAudioPort:(AVAudioSessionPortOverride)portOverride;

/**
 添加监听者监听事件

 @param listener 监听者
 @param event 监听事件
 @param handler 回调方法
 */
- (void) addListener:(id)listener
            forEvent:(JXAudioSessionEvent)event
             handler:(SEL)handler;

/**
移除监听者
 @param listener 监听者
 @param event 监听事件
 */
- (void) removeListener:(id)listener forEvent:(JXAudioSessionEvent)event;


/**
 移除监听者监听的所有事件

 @param listener 监听者
 */
- (void) removeListener:(id)listener;

@end


