//
//  QTMobileAnchorLiveFilterCollectionViewCell.m
//  QTLive
//
//  Created by 张亚超 on 2019/11/29.
//  Copyright © 2019 酷我情天. All rights reserved.
//

#import "QTMobileAnchorLiveFilterCollectionViewCell.h"

@interface QTMobileAnchorLiveFilterCollectionViewCell()
@property (nonatomic, strong)UIImageView *filterimageView;
@property (nonatomic, strong)UILabel *filterNameLabel;
@property (nonatomic, strong)UIImageView *checkImaeView;;

@end
@implementation QTMobileAnchorLiveFilterCollectionViewCell


#pragma mark - Getter
- (UIImageView *)filterimageView
{

    if(_filterimageView == nil){
        _filterimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75.f*DeviceScale6, 75.f*DeviceScale6)];
        _filterimageView.backgroundColor = [UIColor purpleColor];
        _filterimageView.clipsToBounds = YES;
//        _filterimageView.jxCenterY = self.contentView.height/2;
        _filterimageView.layer.cornerRadius = _filterimageView.width/2;
        [self.contentView addSubview:_filterimageView];
    }
    return _filterimageView;
}
- (UILabel *)filterNameLabel
{
    if(_filterNameLabel == nil){
        _filterNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.filterimageView.bottom + 5.f*DeviceScale6, self.contentView.width, 19.f*DeviceScale6)];
        _filterNameLabel.textColor = [UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f];
        _filterNameLabel.font = [UIFont systemFontOfSize:13.f];
        _filterNameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_filterNameLabel];
    }
    return _filterNameLabel;
}
- (UIImageView *)checkImaeView
{
    if(_checkImaeView == nil){
        _checkImaeView = [[UIImageView alloc]initWithFrame:self.filterimageView.bounds];
        _checkImaeView.image = [UIImage imageNamed:@"qt_anchor_live_filter_check_icon"];
        _checkImaeView.contentMode = UIViewContentModeCenter;
//        _checkImaeView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
        [self.filterimageView addSubview:_checkImaeView];
    }
    return _checkImaeView;
}
#pragma mark - Setter
- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
    self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    self.contentView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];

    self.filterimageView.hidden = NO;
    self.filterNameLabel.hidden = NO;
    self.filterNameLabel.text = dataDict[@"cn"];
    NSString *imageName = [@"qt_filter_" stringByAppendingFormat:@"%@_icon",[dataDict[@"en"] lowercaseString]];
    self.filterimageView.image = [UIImage imageNamed:imageName];

}
- (void)setIsSel:(BOOL)isSel
{
    _isSel = isSel;
    self.checkImaeView.hidden = !isSel;
}
@end
