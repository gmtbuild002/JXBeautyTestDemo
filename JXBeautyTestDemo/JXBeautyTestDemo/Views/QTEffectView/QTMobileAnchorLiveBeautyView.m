//
//  QTMobileAnchorLiveBeautyView.m
//  QTLive
//
//  Created by 张亚超 on 2019/11/29.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import "QTMobileAnchorLiveBeautyView.h"


@interface QTMobileAnchorLiveBeautyView ()
{
}
@property (nonatomic, strong) NSMutableArray *progressLabels;

@property (nonatomic, strong) NSArray *beautyLevelKeys;

@end

@implementation QTMobileAnchorLiveBeautyView
#pragma mark - Public Function
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.progressLabels = [[NSMutableArray alloc] init];
        [self createSubViews];
        
    }
    return self;
}
#pragma mark - Private Function
- (void)createSubViews
{
    self.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.20f alpha:1.00f];


    NSArray *titles = @[@"美白", @"大眼", @"瘦脸",@"磨皮"];
    NSArray *types = @[@(QTBeautyType_BeautyWhite),
                       @(QTBeautyType_EnlargeEye),
                       @(QTBeautyType_ShrinkFace),
                       @(QTBeautyType_SmoothStrength)];

    
    NSArray *progress_s = @[@(0.5), @(0), @(0),@(1)];
    for (int i = 0; i < titles.count; i++) {
        float temProgress = [progress_s[i] floatValue];
        NSString *temKey = self.beautyLevelKeys[i];
        NSString *temValue = [[NSUserDefaults standardUserDefaults]objectForKey:temKey];
        if (temValue) {
            temProgress = [temValue floatValue];
            if(temProgress > 1){
                temProgress /= 100.f;
            }
        }
        
        [self creatSubViewWithFrame: CGRectMake(0, i*QTSingleRowHeight, CGRectGetWidth(self.frame), QTSingleRowHeight) withTitle:titles[i] withProgress:temProgress withProgressText:[NSString stringWithFormat:@"%d％", (int)(temProgress*100)] beautyType:[types[i] integerValue]];
    }
}


- (void)creatSubViewWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
                 withProgress:(CGFloat)progress
             withProgressText:(NSString *)progressText
                    beautyType:(QTBeautyType)beautyType
{
    UIView *itemView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:itemView];

    //
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f*DeviceScale6, 0, 30*DeviceScale6, 30.f*DeviceScale6)];
    titleLabel.centerY = itemView.height/2;
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.textColor = [UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [itemView addSubview:titleLabel];

    //
    UISlider *sliderControl = [[UISlider alloc] initWithFrame:CGRectMake(titleLabel.right+10*DeviceScale6, titleLabel.top , self.width - titleLabel.right - 10*DeviceScale6-62.f*DeviceScale6, titleLabel.height)];
    sliderControl.maximumValue = 1;
    sliderControl.minimumValue = 0;
    sliderControl.value = progress;
    sliderControl.minimumTrackTintColor = [UIColor colorWithRed:0.80f green:0.99f blue:0.93f alpha:1.00f];
    sliderControl.maximumTrackTintColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    [sliderControl setThumbImage:[UIImage imageNamed:@"qt_anchor_beauty_pan_icon"] forState:UIControlStateNormal];
    [sliderControl addTarget:self action:@selector(sliderControlAction:) forControlEvents:UIControlEventValueChanged];
    sliderControl.centerY = titleLabel.centerY;
    [itemView addSubview:sliderControl];
    sliderControl.tag = beautyType;
 
    //
    UILabel *progressLbl = [[UILabel alloc] initWithFrame:CGRectMake(sliderControl.right + 8.f*DeviceScale6, sliderControl.top, self.width - (sliderControl.right + 8.f*DeviceScale6), 30.f*DeviceScale6)];
    progressLbl.font = [UIFont systemFontOfSize:14.f];
    progressLbl.textColor = [UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f];
    progressLbl.text = progressText;
    progressLbl.textAlignment = NSTextAlignmentLeft;
    [itemView addSubview:progressLbl];
    [self.progressLabels addObject:progressLbl];
}


#pragma mark - Button Click
- (void)sliderControlAction:(UISlider *)sliderControl {
    
    
    UILabel *progressLbl = self.progressLabels[sliderControl.tag];
    progressLbl.text = [NSString stringWithFormat:@"%d％", (int)(sliderControl.value*100)];
    
    //记录此时的值
    NSString *beautyTypeKey = self.beautyLevelKeys[sliderControl.tag];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f", sliderControl.value] forKey:beautyTypeKey];

    if (self.beautyLevelBlock) {
        self.beautyLevelBlock(sliderControl.tag,sliderControl.value);
    }
    
    
}

#pragma mark - Getter
- (NSArray *)beautyLevelKeys
{
    if(_beautyLevelKeys == nil){
        _beautyLevelKeys = @[@"qt_setBeautyWhiteLevel_key",
                           @"qt_setEnlargeEyeLevel_key",
                           @"qt_setShrinkFaceLevel_key",
                           @"qt_setSmoothStrength_key"];
    }
    return _beautyLevelKeys;
}
@end

