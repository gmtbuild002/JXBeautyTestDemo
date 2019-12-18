//
//  JXHomeViewController.m
//  JXBeautyTestDemo
//
//  Created by 张亚超 on 2019/12/17.
//  Copyright © 2019 KUWO. All rights reserved.
//

#import "JXHomeViewController.h"
#import "QTBeautySettingViewController.h"

@interface JXHomeViewController ()
@property (nonatomic ,strong)UIButton *startLiveButton;
@end

@implementation JXHomeViewController

#pragma mark - About Appear
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self configSubviews];
    
}

#pragma mark - Private Function
- (void)configSubviews
{
    //
    self.startLiveButton.hidden = NO;
    
    
    
}
#pragma mark - Button Click
- (void)startButtonClick:(UIButton *)Button
{
    //
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请复制一条推流地址" message:@"请将推流地址复制到输入框中" preferredStyle:UIAlertControllerStyleAlert];
    
    __block UITextField *inputtextField = nil;
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请复制一条推流";
        inputtextField = textField;
    }];
    
    WEAK_SELF;
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        QTBeautySettingViewController *beautySettingVC = [[QTBeautySettingViewController alloc]init];
        beautySettingVC.modalPresentationStyle = UIModalPresentationFullScreen;
        if(inputtextField)
        {
                //
            beautySettingVC.pushStreamUrl = inputtextField.text; //@"rtmp://kuwopush.fastcdn.com/voicelive/432399220?opstr=publish&tm=1576721830&uid=432399220&roomid=432399220&Md5=3598c70a5a28a9577f5d7f01e65ce2e0";//@"rtmp://192.168.1.104:1935/rtmplive/room";//inputtextField.text;
        }
        [weakSelf presentViewController:beautySettingVC animated:YES completion:^{
            
        }];

    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }]];

    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
    
    
    
    
}
#pragma mark - Getter
- (UIButton *)startLiveButton
{
    if(_startLiveButton == nil)
    {
        _startLiveButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 200.f)];
        _startLiveButton.center = CGPointMake(JXScreenWidth/2, JXScreenHeight/2);
        _startLiveButton.backgroundColor = [UIColor redColor];
        [_startLiveButton setTitle:@"开始直播" forState:UIControlStateNormal];
        [_startLiveButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_startLiveButton];
        
        
    }
    return _startLiveButton;
    
    
}

#pragma mark - Sys
- (void)dealloc
{
    
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
