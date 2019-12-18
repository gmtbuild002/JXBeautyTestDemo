//
//  QTMobileAnchorLiveEffectView.m
//  QTLive
//
//  Created by 张亚超 on 2019/11/29.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import "QTMobileAnchorLiveEffectView.h"

@interface QTMobileAnchorLiveEffectView()<UIScrollViewDelegate>

@property (nonatomic ,strong)UIButton *beautyButton;
@property (nonatomic ,strong)UIButton *filterButton;

@property (nonatomic ,strong)UIView *hLineView;

@property (nonatomic ,strong)UIScrollView *baseScrollView;
//滤镜
@property (nonatomic ,strong)QTMobileAnchorLiveFilterView *filterView;
//美颜
@property (nonatomic, strong)QTMobileAnchorLiveBeautyView *beautyView;

@property (nonatomic ,strong)UIView *bgView;

@end
@implementation QTMobileAnchorLiveEffectView
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self createSubViews];
    }
    return self;
}
#pragma mark - Public Function
- (void)showView{
    

    [self.superview bringSubviewToFront:self.bgView];
    self.bgView.hidden = false;
    [self.superview bringSubviewToFront:self];

    WEAK_SELF;
    [UIView animateWithDuration:0.25 animations:^
     {
         weakSelf.frame = CGRectMake(0, JXScreenHeight - weakSelf.frame.size.height, weakSelf.frame.size.width, weakSelf.frame.size.height);
         
     } completion:^(BOOL finished) {
         if(self.QTEffectViewStatusBlock)
         {
             self.QTEffectViewStatusBlock(YES);
         }
     }];
}
- (void)hiddenView{
    WEAK_SELF;
    self.bgView.hidden = true;
    [UIView animateWithDuration:0.25 animations:^
     {
         weakSelf.frame = CGRectMake(0, JXScreenHeight, weakSelf.frame.size.width, weakSelf.frame.size.height);
     } completion:^(BOOL finished)
     {
        if(self.QTEffectViewStatusBlock)
        {
            self.QTEffectViewStatusBlock(NO);
        }
     }];
    
    //
}
- (void)configAllowTapHidden:(BOOL)isAllow
{
    self.bgView.userInteractionEnabled = isAllow;
    
}
#pragma mark - Private Function
- (void)createSubViews
{
    
    self.backgroundColor = [UIColor colorWithRed:0.15f green:0.15f blue:0.20f alpha:1.00f];
    //
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(18.f, 18.f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = bezierPath.CGPath;
    self.layer.mask = maskLayer;

    
    self.beautyButton.selected = YES;
    self.filterButton.selected = NO;
    
    self.baseScrollView.hidden = NO;
    
    self.beautyView.hidden = NO;
    self.filterView.hidden = NO;
    
    self.hLineView.hidden = NO;

    self.hLineView.centerX = self.beautyButton.centerX;

    
}
#pragma mark - Gesture
- (void)hiddenTapGesture:(UITapGestureRecognizer *)tap
{
    [self hiddenView];
}
#pragma mark - Button Click
- (void)beautyButtonClick:(UIButton *)button
{

    button.selected = YES;
    self.filterButton.selected = NO;
    [UIView animateWithDuration:0.4f animations:^{
        self.baseScrollView.contentOffset = CGPointMake(0, 0);
    }];
    
}
- (void)filterButtonClick:(UIButton *)button
{
    button.selected = YES;
//    self.hLineView.centerX = button.centerX;
    self.beautyButton.selected  = NO;
    
    [UIView animateWithDuration:0.4f animations:^{
        self.baseScrollView.contentOffset = CGPointMake(self.width, 0);
    }];
    
    
    //    if(_filterView == nil){
//        self.filterView.hidden = NO;
//    }
    
}
#pragma mark - Delegate
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //
    CGFloat dis_x = self.filterButton.centerX - self.beautyButton.centerX;
    CGFloat centerX = self.beautyButton.centerX + self.baseScrollView.contentOffset.x / self.baseScrollView.width *dis_x;
    centerX = MIN(self.filterButton.centerX, centerX);
    centerX = MAX(self.beautyButton.centerX, centerX);
    self.hLineView.centerX = centerX;
    
}
#pragma mark - Getter
- (UIButton *)beautyButton
{
    if(_beautyButton == nil)
    {
        _beautyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2 - 150.f*DeviceScale6, 0, 150.f*DeviceScale6,  40.f *DeviceScale6)];
        [_beautyButton setTitle:@"美颜" forState:UIControlStateNormal];
        [_beautyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _beautyButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_beautyButton addTarget:self action:@selector(beautyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_beautyButton];
    }
    return _beautyButton;
}
- (UIButton *)filterButton
{
    if(_filterButton == nil)
    {
        _filterButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2, 0, 150.f*DeviceScale6,  40.f *DeviceScale6)];
        [_filterButton setTitle:@"滤镜" forState:UIControlStateNormal];
        [_filterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _filterButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_filterButton addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_filterButton];
    }
    return _filterButton;
}

- (UIView *)bgView
{
    if(_bgView == nil){
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JXScreenWidth, JXScreenHeight)];
        _bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTapGesture:)];
        [_bgView addGestureRecognizer:tap];
        
    }
    if((_bgView.superview == nil || _bgView.superview != self.superview) && self.superview){
        [self.superview addSubview:_bgView];
    }
    return _bgView;
}
- (UIScrollView *)baseScrollView
{
    if(_baseScrollView == nil){
        
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 62.f*DeviceScale6, self.width, 4*QTSingleRowHeight)];
        _baseScrollView.contentSize = CGSizeMake(self.width*2, 0);
        _baseScrollView.scrollEnabled = YES;
        _baseScrollView.bounces = NO;
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.pagingEnabled = YES;
        _baseScrollView.delegate = self;
        [self addSubview:_baseScrollView];
    }
    return _baseScrollView;
}
- (QTMobileAnchorLiveBeautyView *)beautyView
{
    if(_beautyView == nil){
        _beautyView = [[QTMobileAnchorLiveBeautyView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.baseScrollView.height)];
        [self.baseScrollView addSubview:_beautyView];
        WEAK_SELF;
        
        _beautyView.beautyLevelBlock = ^(QTBeautyType beautyType, CGFloat level) {
          if(weakSelf.beautyLevelBlock){
                weakSelf.beautyLevelBlock(beautyType,level);
            }
        };
    }
    
    return _beautyView;
}
- (QTMobileAnchorLiveFilterView *)filterView
{
    if(_filterView == nil){
        _filterView = [[QTMobileAnchorLiveFilterView alloc]initWithFrame:CGRectMake(self.width, 0, self.width, self.baseScrollView.height)];
        [self.baseScrollView addSubview:_filterView];
        WEAK_SELF;
        _filterView.filterSelectBlock = ^(NSString *filterName, float filterlev) {
            if(weakSelf.filterSelectBlock){
                weakSelf.filterSelectBlock(filterName, filterlev);
            }
        };
    }
    return _filterView;
}

- (UIView *)hLineView
{
    if(_hLineView == nil){
        _hLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.beautyButton.bottom, 100.f*DeviceScale6, 4.f)];
        _hLineView.centerX = self.beautyButton.centerX;
        [self addSubview:_hLineView];
        //
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = _hLineView.bounds;
        gl.startPoint = CGPointMake(1, 0);
        gl.endPoint = CGPointMake(0, 0);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:203/255.0 green:252/255.0 blue:238/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:103/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [_hLineView.layer addSublayer:gl];

    }
    return _hLineView;
}

@end
