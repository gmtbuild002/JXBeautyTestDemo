//
//  JXRecorder.h
//  JuXin
//
//  Created by 张亚超 on 2019/4/15.
//  Copyright © 2019 聚星. All rights reserved.
//

#ifndef JXRecorderEnum_h
#define JXRecorderEnum_h




//录制器音频源
typedef NS_ENUM(NSInteger ,JXRecorderAudioSrc) {
    
    JXRecorderAudioSrc_PhoneMic = 1,        //本地麦克风
    JXRecorderAudioSrc_ThirdSDK,            //第三方来源（eg.即构）
    
};

/**录制器直播时候的状态*/
typedef NS_ENUM(NSInteger ,JXRecorderControllerLiveStatus) {
    JXRecorderControllerLiveStatus_NOP = 0,
    JXRecorderControllerLiveStatus_StartRecord,         //开始录播
    JXRecorderControllerLiveStatus_WriteSuccess,        //写入成功(目前业务层不需要处理)
    JXRecorderControllerLiveStatus_Error,               //出错
    JXRecorderControllerLiveStatus_SuspendBegin,        //延缓开始(目前业务层不需要处理)(后期移除)
    JXRecorderControllerLiveStatus_SuspendEnd,          //延缓结束(目前业务层不需要处理)(后期移除)
    
};

/**录制器录制过程中的问题*/
typedef NS_ENUM(NSInteger ,JXRecorderControllerLiveError) {
    JXRecorderControllerLiveError_None = 1000,
    JXRecorderControllerLiveError_PathError,         //路径问题
    JXRecorderControllerLiveError_WriteError,        //写入问题
    JXRecorderControllerLiveError_TimeOutBegin,      //写入超时开始
    JXRecorderControllerLiveError_TimeOutEnd,        //写入超时结束
    JXRecorderControllerLiveError_ModuleInitError,      //模块初始化出错（eg.音频编码器出错）
    JXRecorderControllerLiveError_ModuleFunctionError,   //模块功能出错（eg.音频编码器编码出错）

};

/**录制器播放音乐时候的状态*/
typedef NS_ENUM(NSInteger ,JXRecorderMusicStatus) {
    JXRecorderMusicStatus_Nop = 0,
    JXRecorderMusicStatus_PreparedPlay,
    JXRecorderMusicStatus_Progress,       //播放进度
    JXRecorderMusicStatus_PlayPause,      //暂停
    JXRecorderMusicStatus_PlayResume,      //继续
    JXRecorderMusicStatus_PlayEnd,
    JXRecorderMusicStatus_Replay,         //
    JXRecorderMusicStatus_Error,         //


};


typedef NS_ENUM(NSInteger, JXRecorderAutoBitrateType) {
    
    JXRecorderAutoBitrateType_HIGH = 8,
    JXRecorderAutoBitrateType_MID,
    JXRecorderAutoBitrateType_LOW,
};
//
typedef NS_OPTIONS(NSUInteger, JXLogLevelType) {

    JX_LOG_NORMAL         =  1 << 0,      //流程打印打印
    JX_LOG_FAILE          =  1 << 1,      //模块功能失败打印
    JX_LOG_STATRISTICS    =  1 << 2,      //统计打印

};

#endif /* JXRecorderEnum_h */
