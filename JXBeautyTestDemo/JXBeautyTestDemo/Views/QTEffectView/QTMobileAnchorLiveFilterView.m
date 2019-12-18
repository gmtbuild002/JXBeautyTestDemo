//
//  QTMobileAnchorLiveFilterView.m
//  QTLive
//
//  Created by 张亚超 on 2019/11/29.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import "QTMobileAnchorLiveFilterView.h"

#import "QTMobileAnchorLiveFilterCollectionViewCell.h"

@interface QTMobileAnchorLiveFilterView()<UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _selectIndex;
}
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic ,strong)NSArray *dataSource;
@property (nonatomic ,strong)NSMutableDictionary *filterLevDict;

@property (nonatomic ,strong)UISlider *filterLevSlider;

@end
static NSString *cellId = @"QT_FilterCollectionViewCell_ID";
@implementation QTMobileAnchorLiveFilterView
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self createSubviews];
    }
    return self;
}
#pragma mark - Function
- (void)createSubviews
{
    _selectIndex = 0;
    self.collectionView.hidden = false;
    self.filterLevSlider.hidden = YES;
}
#pragma mark - Button Click
- (void)filterSliderValueChanged:(UISlider *)slider
{
    if(_selectIndex <= 0){
        return;
    }
    NSDictionary *dataDict = self.dataSource[_selectIndex];
    NSString *filter = dataDict[@"en"];
    self.filterLevDict[filter] = @(slider.value);
    if(self.filterSelectBlock){
        self.filterSelectBlock([filter lowercaseString], slider.value);
    }

}
#pragma mark - Delegate
#pragma mark - UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QTMobileAnchorLiveFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.dataDict = self.dataSource[indexPath.item];
    cell.isSel = indexPath.item == _selectIndex;

    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if(_selectIndex == indexPath.item){
        return;
    }
    _selectIndex = indexPath.item;
    [collectionView reloadData];
    self.filterLevSlider.hidden = indexPath.item == 0;
    NSDictionary *dataDict = self.dataSource[indexPath.item];
    NSString *enName = dataDict[@"en"];
    float filterLev = 0.5;
    if([self.filterLevDict.allKeys containsObject:enName]){
        filterLev = [self.filterLevDict[enName] floatValue];
    }
    
    self.filterLevSlider.value = filterLev;
    //获取
    NSString *filterName = [enName lowercaseString];
    if(self.filterSelectBlock){
        self.filterSelectBlock(filterName, filterLev);
    }
}
#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if(_collectionView == nil){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30.f*DeviceScale6, self.width, 120.f*DeviceScale6) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[QTMobileAnchorLiveFilterCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLayout
{
    if(_flowLayout == nil){
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake(75.f*DeviceScale6, 99.f*DeviceScale6);
        _flowLayout.minimumLineSpacing = 20.f*DeviceScale6;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 20.f*DeviceScale6, 0, 20.f*DeviceScale6);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}
- (UISlider *)filterLevSlider
{
    if(_filterLevSlider == nil){
        _filterLevSlider = [[UISlider alloc]initWithFrame:CGRectMake(16.f * DeviceScale6, 156.f*DeviceScale6, self.width - 32.f*DeviceScale6,49.f*DeviceScale6)];
        _filterLevSlider.minimumValue = 0;
        _filterLevSlider.maximumValue = 1;
        _filterLevSlider.minimumTrackTintColor = [UIColor colorWithRed:0.80f green:0.99f blue:0.93f alpha:1.00f];
        _filterLevSlider.maximumTrackTintColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:0.85f];
        [_filterLevSlider addTarget:self action:@selector(filterSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_filterLevSlider];
    }
    return _filterLevSlider;
}
- (NSArray *)dataSource
{
    if(_dataSource == nil){
        _dataSource = @[
                        @{@"en":@"origin",@"cn":@"原图"},
                        @{@"en":@"ziran",@"cn":@"自然"},
                        @{@"en":@"hongrun",@"cn":@"红润"},
                        @{@"en":@"fennen",@"cn":@"少女"},
                        @{@"en":@"Warm",@"cn":@"温暖"},
                        @{@"en":@"qingxin",@"cn":@"清新"},
                        @{@"en":@"Tokyo",@"cn":@"日风"},

//                        @{@"en":@"danya",@"cn":@"淡雅"},
//                        @{@"en":@"fennen",@"cn":@"粉嫩"},
//                        @{@"en":@"Delta",@"cn":@"Delta"},
//                        @{@"en":@"Electric",@"cn":@"Electric"},
//                        @{@"en":@"Slowlived",@"cn":@"Slowlived"},
                        ];
    }
    return _dataSource;
}
- (NSMutableDictionary *)filterLevDict
{
    if(_filterLevDict == nil){
        _filterLevDict = [[NSMutableDictionary alloc]init];
    }
    return _filterLevDict;
}
@end
