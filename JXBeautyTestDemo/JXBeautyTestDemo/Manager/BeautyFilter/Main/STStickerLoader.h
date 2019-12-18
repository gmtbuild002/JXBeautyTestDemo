//
//  STStikcerLoader.h
//  PLCameraStreamingKit
//
//  Created by TaoRan on 16/6/21.
//  Copyright © 2016年 0dayZh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STStickerLoader : NSObject

// 初始化化时可以强制复制一次资源，上层可以根据版本信息有无变化来设置
+ (void)ForceUpdateAtInit;
+ (void)updateTheStickers;

+ (NSArray *)getStickersPaths;

@end
