//
//  FULiveModel.h
//
//  Created by wh on 2018/12/5.
//  Copyright © 2018年 L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUMusicPlayer : NSObject

@property (nonatomic, assign) BOOL enable;

+ (FUMusicPlayer *)sharePlayer;

- (void)playMusic:(NSString *)music;

- (void)rePlay;

- (void)stop;

- (void)resume;

- (void)pause;

- (float)playProgress;

- (NSTimeInterval)currentTime;
@end
