//
//  QTMobileAnchorLiveFilterView.h
//  QTLive
//
//  Created by 张亚超 on 2019/11/29.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^QTFilterSelectBlock)(NSString * _Nullable filterName, float filterlev);

/// 滤镜视图
@interface QTMobileAnchorLiveFilterView : UIView
@property (nonatomic ,copy)QTFilterSelectBlock filterSelectBlock;
@end

NS_ASSUME_NONNULL_END
