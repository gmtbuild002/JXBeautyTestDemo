//
//  JXStickerManage.m
//  JuXin
//
//  Created by wanghui on 2016/11/15.
//  Copyright © 2016年 聚星. All rights reserved.
//

#import "FUManager.h"
#import "FULiveModel.h"
#import "JXStickerManage.h"
#import <CommonCrypto/CommonDigest.h>
#import "STStickerLoader.h"

@interface JXStickerManage()
{
}
    
@property (nonatomic, strong) FULiveModel * model;
    
@end

@implementation JXStickerManage
{
}


-(id)init{
   if(self = [super init])
   {
       [[FUManager shareManager] loadFilter];
       [[FUManager shareManager] setAsyncTrackFaceEnable:NO];
       [FUManager shareManager].enableMaxFaces = 3;
       [FUManager shareManager].performance = FALSE;
       
       NSArray * dataArray = [FUManager shareManager].dataSource;
       if(dataArray){
           int i = 0;
           for(i = 0; i < dataArray.count; i++){
               FULiveModel * model = dataArray[i];
               if(model){
                   if(model.type == FULiveModelTypeBeautifyFace){
                       [FUManager shareManager].currentModel = model;
                       break;
                   }
               }
           }
           if(i == dataArray.count){
               [FUManager shareManager].currentModel = dataArray[0];
           }
       }
       
       self.model = [FUManager shareManager].currentModel;
       
       //        [[FUManager shareManager] loadItem:@"hair_color"];
       //        [[FUManager shareManager] setHairColor:0];
       //        [[FUManager shareManager] setHairStrength:0.5];
       
       NSString *selectItem = @"noitem";//self.model.items.count > 0 ? self.model.items[0] : @"noitem";
       
//       selectItem = @"future_warrior";
//       selectItem = @"noitem";
       
       [[FUManager shareManager] loadItem: selectItem];
       
       if(self.model){
           switch (self.model.type) {
               case FULiveModelTypeBeautifyFace:{      // 美颜
               }
                   break;
                   
               case FULiveModelTypeMakeUp:{            //  美妆
                   [[FUManager shareManager] setAsyncTrackFaceEnable:NO];
               }
                   break ;
                   
               case FULiveModelTypeHair:{
                   [[FUManager shareManager] loadItem:@"hair_color"];
                   [[FUManager shareManager] setHairColor:0];
                   [[FUManager shareManager] setHairStrength:0.5];
               }
                   break ;
                   
               default:{                               // 道具
                   //                    NSString *selectItem = self.model.items.count > 0 ? self.model.items[0] : @"noitem" ;
                   //                    self.itemsView.selectedItem = selectItem ;
                   //                    [[FUManager shareManager] loadItem: selectItem];
                   //
                   //                    dispatch_async(dispatch_get_main_queue(), ^{
                   //
                   //                        NSString *alertString = [[FUManager shareManager] alertForItem:selectItem];
                   //                        self.alertLabel.hidden = alertString == nil ;
                   //                        self.alertLabel.text = NSLocalizedString(alertString, nil) ;
                   //
                   //                        [FURenderViewController cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissAlertLabel) object:nil];
                   //                        [self performSelector:@selector(dismissAlertLabel) withObject:nil afterDelay:3];
                   //
                   //                        NSString *hint = [[FUManager shareManager] hintForItem:selectItem];
                   //                        self.tipLabe.hidden = hint == nil;
                   //                        self.tipLabe.text = NSLocalizedString(hint, nil);
                   //
                   //                        [FURenderViewController cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissTipLabel) object:nil];
                   //                        [self performSelector:@selector(dismissTipLabel) withObject:nil afterDelay:5 ];
                   //                    });
               }
                   break;
           }
       }

       
       
   }
    return self;
}
    
 - (void) dealloc
{
    [[FUManager shareManager] destoryItems];
}

//设置滤镜名称：滤镜、美颜滤镜 滤镜程度
- (void)setFilterName:(NSString *)filterName filterLev:(float)filterLev
{
    [FUManager shareManager].selectedFilter = filterName;
    [FUManager shareManager].selectedFilterLevel = (double)filterLev;
}
    

- (void)setBeautyWhiteLevel:(float)iLevel
{
//    [FUManager shareManager].skinDetectEnable = NO;
//    [FUManager shareManager].blurShape = 0.0;
//    [FUManager shareManager].blurLevel = 0;
    [FUManager shareManager].whiteLevel = iLevel;
    [FUManager shareManager].redLevel = 1.0;
}


// 设置默认大眼参数 大眼比例, [0,1.0], 0.0不做大眼效果
- (void)setEnlargeEyeLevel:(float)ratio{
//    [FUManager shareManager].skinDetectEnable = true;
    [FUManager shareManager].enlargingLevel = ratio;
    [FUManager shareManager].enlargingLevel_new = ratio;
}
    
//设置磨皮参数,
- (void)setSmoothStrength:(float)ratio{
    [FUManager shareManager].blurLevel = ratio;
}
    
// 设置默认瘦脸参数瘦脸比例, [0,1.0], 0.0不做瘦脸效果
- (void)setShrinkFaceLevel:(float)ratio{
//    [FUManager shareManager].skinDetectEnable = true;
    [FUManager shareManager].thinningLevel = ratio;
    [FUManager shareManager].thinningLevel_new = ratio;
}

// 设置短下巴参数缩下巴比例, [0,1.0], 0.0不做缩下巴效果
- (void)setShrinkJawLevel:(float)ratio{
    [FUManager shareManager].jewLevel = ratio;
}
    
-(void) setEnableSticker:(BOOL)enableSticker{
    [[FUManager shareManager] loadItem:@"noitem"];
}
    
-(void) setNeedChangeSticker:(NSString *)stickerTitle{
    if(stickerTitle){
        [[FUManager shareManager] loadItem: stickerTitle];
    }else{
        [[FUManager shareManager] loadItem:@"noitem"];
    }
}

- (void)processVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    bool hidden = false;

    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [[FUManager shareManager] renderItemsToPixelBuffer:pixelBuffer];
    
    /**判断是否检测到人脸*/
    hidden = [[FUManager shareManager] isTracking];
}

@end
