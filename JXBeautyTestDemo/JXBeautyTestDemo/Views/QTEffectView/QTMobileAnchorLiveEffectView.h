//
//  QTMobileAnchorLiveEffectView.h
//  QTLive
//
//  Created by 张亚超 on 2019/11/29.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTMobileAnchorLiveBeautyView.h"
#import "QTMobileAnchorLiveFilterView.h"


NS_ASSUME_NONNULL_BEGIN

@interface QTMobileAnchorLiveEffectView : UIView

@property (nonatomic ,copy)void (^QTEffectViewStatusBlock)(BOOL isShow);
@property (nonatomic ,copy)QTBeautyLevelBlock beautyLevelBlock;
@property (nonatomic ,copy)QTFilterSelectBlock filterSelectBlock;

- (void)showView;

- (void)configAllowTapHidden:(BOOL)isAllow;

@end

NS_ASSUME_NONNULL_END
