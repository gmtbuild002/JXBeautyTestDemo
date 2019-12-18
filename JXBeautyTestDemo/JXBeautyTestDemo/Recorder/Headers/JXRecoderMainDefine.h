//
//  JXRecoderMainDefine.h
//  JXPlayer
//
//  Created by 张亚超 on 2019/9/24.
//  Copyright © 2019 zhangyachao. All rights reserved.
//

#ifndef JXRecoderMainDefine_h
#define JXRecoderMainDefine_h

#import "JXRecorderEnum.h"

//#define JX_USE_NEW_RECORDER_STEP_1 1 //(功能拆分 + 底层C 的驱动)
//#define JX_USE_NEW_RECORDER_STEP_2 1 //(功能拆分 + 自定义Mixer + 自定义播放器)
//
#define JX_RECORDER_WEAK_SELF __weak typeof(self)weakSelf = self
//
#define JX_STRING_EMPTY(str) \
([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//关于打印
static JXLogLevelType levelType = JX_LOG_FAILE|JX_LOG_NORMAL;

#if (defined DEBUG) || (defined _DEBUG)
#define JXLog(class,level,message,...) \
if(level & levelType){\
    if(JX_STRING_EMPTY(message) == NO){\
    NSLog(@"jx_class:%@ func:%s message:%@",class,__func__,[NSString stringWithFormat:(message),##__VA_ARGS__]);\
    }else\
    {\
        NSLog(@"jx_class:%@ func:%s",class,__func__);\
    }\
}
#else
#define JXLog(class,level,message,...) {}
#endif

#define JXLog_S(class,message,...)\
JXLog(class,JX_LOG_STATRISTICS,message,##__VA_ARGS__)


#define JXLog_F(class,message,...)\
JXLog(class,JX_LOG_FAILE,message,##__VA_ARGS__)

#define JXLog_N(class,message,...)\
JXLog(class,JX_LOG_NORMAL,message,##__VA_ARGS__)





//
#define JX_M_LN10  2.30258509299404568402  /* natural log of 10 */
#define jx_dB_to_linear( dB ) exp( ( dB ) * JX_M_LN10 * 0.05 )
// volume dB { -limit, -20, -15, -10, -5, 0, 1, 2, 3, 4, 5 }
#define jx_volume_level_to_linear( level ) ( ( level == -5 ) ? 0.0 : ( ( level < 0 ) ? jx_dB_to_linear( level * 5 ) : jx_dB_to_linear( level ) ) )


//nal_unit_type_e
#define JX_NAL_UNIT_IDR_TYPE (5)
#define JX_NAL_UNIT_SEI_TYPE (6)


/***********          日志使用            *************/
#define JXRecorderLogInfoNotification @"JXRecorderLogInfoNotification"
//cpu 消耗（%）
#define jx_recorder_statistics_cpu_usag @"cpu_usag"
//内存 消耗（M）
#define jx_recorder_statistics_memory_usag @"memory_usag"
//自动重连次数
#define jx_recorder_statistics_restart_times @"restart_times"
//统计周期（s）
#define jx_recorder_statistics_circle_seconds @"circle_seconds"
//设置帧数
#define jx_recorder_statistics_setting_fps @"setting_fps"
//发送帧数
#define jx_recorder_statistics_send_fps @"send_fps"
//采集帧数
#define jx_recorder_statistics_capture_fps @"capture_fps"
//编码帧数
#define jx_recorder_statistics_encode_fps @"encode_fps"

//发送码率(bps)
#define jx_recorder_statistics_send_bitrate @"send_bitrate"
//编码码率(bps)
#define jx_recorder_statistics_encode_bitrate @"encode_bitrate"
//丢帧率（%）
#define jx_recorder_statistics_discard_rate @"discard_rate"
//周期丢帧数
#define jx_recorder_statistics_circle_discard_count @"circle_discard_count"


/***********          水印使用            *************/
#define JXVideoWatermarkMemberNameKey @"name"
#define JXVideoWatermarkMemberValueKey @"value"
#define JXVideoWatermarkMemberFrameKey @"frame"
//文字使用
#define JXVideoWatermarkMemberAttributesKey @"attributes"

#define JXVideoWatermarkMemberName_Image @"image"
#define JXVideoWatermarkMemberName_Text @"text"


#endif /* JXRecoderMainDefine_h */
