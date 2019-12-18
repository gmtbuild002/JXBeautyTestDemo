//
//  QTMobileAnchorLiveBeautyView.h
//  QTLive
//
//  Created by 张亚超 on 2019/11/29.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//美颜类型
typedef NS_ENUM(NSInteger ,QTBeautyType) {
    QTBeautyType_BeautyWhite = 0,       //美白
    QTBeautyType_EnlargeEye,            //大眼
    QTBeautyType_ShrinkFace,            //瘦脸
    QTBeautyType_SmoothStrength,        //磨皮
};
typedef void(^QTBeautyLevelBlock)(QTBeautyType beautyType,CGFloat level);

#define QTSingleRowHeight (49.f*DeviceScale6)
/// 美颜视图
@interface QTMobileAnchorLiveBeautyView : UIView
// 美颜等模块滑块进度条。
@property (nonatomic, copy) QTBeautyLevelBlock beautyLevelBlock;

@end

NS_ASSUME_NONNULL_END
