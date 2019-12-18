//
//  FULiveModel.h
//
//  Created by wh on 2018/12/5.
//  Copyright © 2018年 L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FUImageHelper : NSObject

+ (void) convertUIImageToBitmapRGBA8:(UIImage *) image completionHandler:(void (^)(int32_t size, unsigned char * bits))completionHandler;
@end
