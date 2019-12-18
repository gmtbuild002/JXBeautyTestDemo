//
//  QTMobileLiveManager.m
//  QTLive
//
//  Created by 张亚超 on 2019/11/20.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import "QTMobileLiveManager.h"

#import "JXMediaRecorderController.h"

#import "JXStickerManage.h"

@interface QTMobileLiveManager()<JXMediaRecorderControllerDelegate,JXMediaRecorderControllerCaptureDelegate>
{

    //
}

//new add
@property (nonatomic ,strong)JXMediaRecorderController *recorderController;

@property (nonatomic ,strong)QTMobileAnchorLiveEffectView *effectView;

@property (nonatomic ,strong)UIImage *liveCoverImage;

@property (nonatomic ,strong)JXStickerManage *stickerManager;
@end

@implementation QTMobileLiveManager

#pragma mark - Public Function

+ (instancetype)shareInstance
{
    static QTMobileLiveManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[QTMobileLiveManager alloc]init];
    });
    return _instance;
}


+ (UIView *)startRecorderPreviewViewWithFrame:(CGRect)frame
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    return [manager.recorderController startVideoPreviewWithFrame:frame];
}

+ (void)updateAnchorLiveCoverImage:(UIImage *)coverImage{
    //
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    manager.liveCoverImage = coverImage;
    
}

+ (void)startLiveWithPushStreamUrl:(NSString *)pushStreamUrl
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    //
    [manager.recorderController startMobileLiveWithPushStreamUrl:pushStreamUrl];
    
}
//
+ (void)pauseLive
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    [manager.recorderController pauseLive];
}
//
+ (void)resumeLive
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    [manager.recorderController resumeLive];
    
    
}
//
+ (void)stopLive
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    [manager.recorderController stopLive];
    
}
//
+ (void)restartLive
{
    //
    
//    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
//    manager->_hadSentStartRecordLogs = NO;
//    manager.openLiveDate = [NSDate date];
//    [manager getPushStreamUrlWithResultBlock:^{
//        //开始新的录制
//        [manager.recorderController restartOpenLiveWithPushStreamUrl:manager.pushStreamUrl];
//    } faileBlock:^{
//
//    }];
    
    
}

//切换前后摄像头
+ (void)switchCameraDirection{
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    [manager.recorderController switchCameraDirection];
}
//设置闪光灯
+ (void)changeFlashMode{
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    [manager.recorderController changeFlashMode];
    
}

#pragma mark - Public Function - 调节美颜设置

//设置大眼
+ (void)configEnlargeEyeLevel:(float)level{
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    if (manager.stickerManager != nil) {
        [manager.stickerManager setEnlargeEyeLevel:level];
    }

}
//设置美颜
+ (void)configBeautifyLevel:(float)level{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    if (manager.stickerManager != nil) {
        [manager.stickerManager setBeautyWhiteLevel:level];
    }

}
//瘦脸
+ (void)configShrinkFaceLevel:(float)level{
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    if (manager.stickerManager != nil) {
        [manager.stickerManager setShrinkFaceLevel:level];
    }

}
//磨皮
+ (void)configSmoothStrength:(float)level{
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    
    if (manager.stickerManager != nil) {
        [manager.stickerManager setSmoothStrength:level];
    }

}
//设置滤镜名称：滤镜、美颜滤镜 滤镜程度
+ (void)configFilterName:(NSString *)filterName filterLev:(float)filterLev
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    if (manager.stickerManager != nil) {
        [manager.stickerManager setFilterName:filterName filterLev:filterLev];
    }

}

+ (void)configEnableSticker:(BOOL)enableSticker{
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    if (manager.stickerManager != nil) {
        [manager.stickerManager setEnableSticker:enableSticker];
    }

}
+ (void)configNeedChangedSticker:(NSString *)stickerTitle{
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    if (manager.stickerManager != nil) {
        [manager.stickerManager setNeedChangeSticker:stickerTitle];
    }
}

#pragma mark - Public Function - Other
+ (QTMobileAnchorLiveEffectView *)fetchRecorderEffectView
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    return manager.effectView;
}

+ (void)configRecorderLogMode:(BOOL)logMode
{
    //
    
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    [manager.recorderController configRecorderLogMode:logMode];
    //监听日志信息的回调
    
}
+ (NSArray *)recorderLogPaths
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    return [manager.recorderController recorderLogPaths];
}

+ (void)destory
{
    QTMobileLiveManager *manager = [QTMobileLiveManager shareInstance];
    manager.liveCoverImage = nil;
    if(manager->_recorderController){
        
        [manager.recorderController destory];
        manager.recorderController = nil;
        
    }
    if(manager->_effectView)
    {
        [manager->_effectView removeFromSuperview];
        manager->_effectView = nil;
    }
//    if(manager->_stickerManager)
//    {
//        //
//        manager.stickerManager = nil;
//    }
}
#pragma mark - Private Function
- (instancetype)init
{
    if(self = [super init])
    {
        [self initConfig];
    }
    return self;
}
- (void)initConfig{
    [self createStickerManager];
    //
}
- (void)createStickerManager{
    //
    self.stickerManager = [[JXStickerManage alloc]init];

}
//获取主播直播用的信息，包括推流地址
- (void)getAnchorLiveSigWithSuccessedBlock:(dispatch_block_t)successedBlock
                               failedBlock:(void(^)(NSString *message))failedBlock
{
    //
//    WEAK_SELF;
//    [QTMobileAnchorLiveSigModel anchorLiveSigWithVideoquality:1 singerUid:111 longitude:0 latitude:0 successedBlock:^(QTMobileAnchorLiveSigModel * _Nonnull sigModel) {
//        [weakSelf updateAnchorLiveSig:sigModel];
//        if(successedBlock)
//        {
//            successedBlock();
//        }
//    } failedBlock:^(NSString * _Nonnull message) {
//        if(failedBlock)
//        {
//            failedBlock(message);
//        }
//    }];
    
    
}

#pragma mark - Delegate
#pragma mark - <JXMediaRecorderControllerDelegate>
//播放音乐时状态反馈
- (void)jx_newRecorderControllerPlayMusicStatusChanged:(JXRecorderMusicStatus)status
                                    recorderController:(JXMediaRecorderController *)recorderController
{

}
//直播时状态反馈
- (void)jx_newRecorderControllerLiveStatusChanged:(JXRecorderControllerLiveStatus)status
                                        liveError:(NSError *)liveError
                               recorderController:(JXMediaRecorderController *)recorderController
{
    if(recorderController != self.recorderController){
        return;
    }
    
}
#pragma mark - JXMediaRecorderControllerCaptureDelegate
- (void)internalCaptureSampleBufferCallback:(CMSampleBufferRef _Nonnull)sampleBuffer recorderController:(JXMediaRecorderController *)recorderController
{
    //
    if(_stickerManager)
    {
        NSDate *date = [NSDate date];

        [self.stickerManager processVideoSampleBuffer:sampleBuffer];
        float stickerTime = fabs([date timeIntervalSinceNow]) *1000;
        if(stickerTime > 45.f)
        {
            NSLog(@"Sticker Time:%f (ms)",stickerTime);
        }

    }
    
}

#pragma mark - Getter
- (JXMediaRecorderController *)recorderController
{
    if(_recorderController == nil){
        _recorderController = [[JXMediaRecorderController alloc]init];
        _recorderController.delegate = self;
        _recorderController.captureDelegate = self;
        
#if (defined DEBUG) || (defined _DEBUG)
        [_recorderController configRecorderLogMode:YES];
#endif
    }
    return _recorderController;
}
- (QTMobileAnchorLiveEffectView *)effectView
{
    if(_effectView == nil){
        _effectView = [[QTMobileAnchorLiveEffectView alloc]initWithFrame:CGRectMake(0, JXScreenHeight, JXScreenWidth, 62.f*DeviceScale6 + 4*QTSingleRowHeight)];
        
        _effectView.beautyLevelBlock = ^(QTBeautyType beautyType, CGFloat level) {
//            NSLog(@"beautyType:%ld - level:%f",(long)beautyType,level);
            switch (beautyType) {
                case QTBeautyType_BeautyWhite:
                    [QTMobileLiveManager configBeautifyLevel:level];
                    break;
                case QTBeautyType_EnlargeEye:
                    [QTMobileLiveManager configEnlargeEyeLevel:level];
                    break;
                case QTBeautyType_ShrinkFace:
                    [QTMobileLiveManager configShrinkFaceLevel:level];
                    break;
                case QTBeautyType_SmoothStrength:
                    [QTMobileLiveManager configSmoothStrength:level];
                    break;

                default:
                    break;
            }

        };

        //        //滤镜
        _effectView.filterSelectBlock = ^(NSString *filterName, float filterlev) {
            //
            [QTMobileLiveManager configFilterName:filterName filterLev:filterlev];
        };
    }
    return _effectView;
}



@end
