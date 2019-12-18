//
//  QTBeautySettingViewController.m
//  QTLive
//
//  Created by 张亚超 on 2019/12/9.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import "QTBeautySettingViewController.h"
#import "QTMobileLiveManager.h"
#import "QTDevicePermissionManager.h"
@interface QTBeautySettingViewController ()
@property (nonatomic, weak)UIView * previewView;

@property (nonatomic, strong)UIButton *closeButton;
@property (nonatomic, strong)UIButton *beautyButton;

@property (nonatomic, weak) QTMobileAnchorLiveEffectView *effectView;



@end

@implementation QTBeautySettingViewController

#pragma mark - About Appear
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self configSubviews];
    [self createVideoRecorder];
    
    //
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.pushStreamUrl && [self.pushStreamUrl isEqualToString:@""] == NO && [self.pushStreamUrl hasPrefix:@"rtmp"])
    {
        [QTMobileLiveManager startLiveWithPushStreamUrl:self.pushStreamUrl];
    }
}

#pragma mark - Private Function
- (void)configSubviews
{
    //
    self.beautyButton.hidden = NO;
    self.closeButton.hidden = NO;
    self.effectView.hidden = NO;
    
}
- (void)createVideoRecorder {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_enter(group);

    __block BOOL videoPermission = NO;
    __block BOOL audioPermission = NO;
    //
    WEAK_SELF;
    [QTDevicePermissionManager checkCamarePermissionWithHandler:^(BOOL firstDetermine, BOOL granted) {
        
        videoPermission = granted;
        dispatch_group_leave(group);
    }];
    
    [QTDevicePermissionManager checkMicphonePermissionWithHandler:^(BOOL firstDetermine, BOOL granted) {
        
       audioPermission = granted;
       dispatch_group_leave(group);
    }];
    //
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if(videoPermission)
        {
            weakSelf.previewView = [QTMobileLiveManager startRecorderPreviewViewWithFrame:self.view.bounds];
            [weakSelf.view addSubview:weakSelf.previewView];
            [weakSelf.view sendSubviewToBack:weakSelf.previewView];

        }
        
        if(videoPermission == NO || audioPermission == NO)
        {
            NSString *alertTitle = @"";
            if(videoPermission == NO && audioPermission == NO)
            {
                alertTitle = @"摄像头和麦克风访问受限，请修改设置";
            }
            if(videoPermission == NO &&  audioPermission)
            {
                alertTitle = @"摄像头访问受限，请修改设置";
            }
            if(videoPermission &&  audioPermission == NO)
            {
                alertTitle = @"麦克风访问受限，请修改设置";
            }
            UIAlertController * alertC = [UIAlertController alertControllerWithTitle:alertTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self.navigationController presentViewController:alertC animated:YES completion:nil];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self closeButtonClick:nil];
            }];
            [alertC addAction:action];
            
        }
        

    });
}



#pragma mark - Button Click
- (void)closeButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)beautyButtonClick:(UIButton *)button
{
    //
    self.beautyButton.hidden = YES;
    [self.effectView showView];
}
#pragma mark - Getter
- (UIButton *)closeButton
{
    if(_closeButton == nil)
    {
        _closeButton = [[UIButton alloc]initWithFrame:CGRectMake(14.f*DeviceScale6, self.beautyButton.top, 64.f*DeviceScale6, self.beautyButton.height)];
        [_closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.right = JXScreenWidth - 16.f*DeviceScale6;
        _closeButton.clipsToBounds = YES;
        _closeButton.layer.cornerRadius = _closeButton.height/2;
        [_closeButton setTitle:@"完成" forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:14.f];

        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = _closeButton.bounds;
        gl.startPoint = CGPointMake(1, 0);
        gl.endPoint = CGPointMake(0, 0);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:203/255.0 green:252/255.0 blue:238/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:103/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [_closeButton.layer insertSublayer:gl below:_closeButton.titleLabel.layer];

        
        
        [self.view addSubview:_closeButton];
        
        
    }
    return _closeButton;
    
}
- (QTMobileAnchorLiveEffectView *)effectView
{
    if(_effectView == nil){
        _effectView = [QTMobileLiveManager fetchRecorderEffectView];
        _effectView.top = self.view.height;
        [_effectView configAllowTapHidden:YES];
        [self.view addSubview:_effectView];
        //
        WEAK_SELF;
        _effectView.QTEffectViewStatusBlock = ^(BOOL isShow) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(isShow == NO)
                {
                    weakSelf.beautyButton.hidden = NO;
                }
            });
        };
    }
    return _effectView;
}
- (UIButton *)beautyButton
{
    if(_beautyButton == nil)
    {
        _beautyButton = [[UIButton alloc]initWithFrame:CGRectMake(16.f*DeviceScale6, 24.f*DeviceScale6, 80.f*DeviceScale6, 30.f*DeviceScale6)];
        [_beautyButton setTitle:@"美颜设置" forState:UIControlStateNormal];
        _beautyButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _beautyButton.clipsToBounds = YES;
        _beautyButton.layer.cornerRadius = _beautyButton.height/2;
        [_beautyButton addTarget:self action:@selector(beautyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = _beautyButton.bounds;
        gl.startPoint = CGPointMake(1, 0);
        gl.endPoint = CGPointMake(0, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:247/255.0 green:205/255.0 blue:176/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:219/255.0 green:168/255.0 blue:246/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [_beautyButton.layer insertSublayer:gl below:_beautyButton.titleLabel.layer];

        [self.view addSubview:_beautyButton];
    }
    return _beautyButton;
    
    
}

#pragma mark - Sys
- (void)dealloc
{
    [QTMobileLiveManager destory];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
