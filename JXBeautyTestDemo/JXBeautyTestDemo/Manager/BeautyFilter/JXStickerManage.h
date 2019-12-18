//
//  JXStickerManage.h
//  JuXin
//
//  Created by wanghui on 2016/11/15.
//  Copyright © 2016年 聚星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JXStickerManage : NSObject


//设置滤镜名称：滤镜、美颜滤镜 滤镜程度
- (void)setFilterName:(NSString *)filterName filterLev:(float)filterLev;

- (void) setEnableSticker:(BOOL)enableSticker;
//改变
- (void) setNeedChangeSticker:(NSString *)stickerTitle;
//设置美白
- (void)setBeautyWhiteLevel:(float)iLevel;
// 设置大眼参数 大眼比例, [0,1.0], 0.0不做大眼效果
- (void)setEnlargeEyeLevel:(float)ratio;

//设置瘦脸参数瘦脸比例, [0,1.0], 0.0不做瘦脸效果
- (void)setShrinkFaceLevel:(float)ratio;

//设置短下巴参数缩下巴比例, [0,1.0], 0.0不做缩下巴效果
- (void)setShrinkJawLevel:(float)ratio;

//设置磨皮参数[0,1.0]
- (void)setSmoothStrength:(float)ratio;
    
- (void)processVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;
    
@end
