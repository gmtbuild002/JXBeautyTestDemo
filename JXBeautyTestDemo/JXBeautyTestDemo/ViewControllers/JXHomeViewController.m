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
        //
        if(inputtextField)
        {
            //
            beautySettingVC.pushStreamUrl = inputtextField.text;
            
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
//        _startLiveButton.backgroundColor = [UIColor redColor];
        [_startLiveButton setTitle:@"开始直播" forState:UIControlStateNormal];
        [_startLiveButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_startLiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:_startLiveButton];
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = _startLiveButton.bounds;
        gl.startPoint = CGPointMake(1, 0);
        gl.endPoint = CGPointMake(0, 0);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:203/255.0 green:252/255.0 blue:238/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:103/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [_startLiveButton.layer insertSublayer:gl below:_startLiveButton.titleLabel.layer];

        

        
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
