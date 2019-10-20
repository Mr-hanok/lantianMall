//
//  StoreRatingsCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  店铺评分

#import "StoreRatingsCell.h"
#import "EvaluationView.h"
@interface StoreRatingsCell ()

@end
@implementation StoreRatingsCell
{
    EvaluationView * descriptionMatchLv; ///< 描述相符
    EvaluationView * deliverySpeedLv; ///< 发货速度
    EvaluationView * serviceAttitudeLv; ///< 服务态度

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setup];
        /**
         *  默认评价三颗心
         */
        descriptionMatchLv.scorePercent = 0.6f;
        deliverySpeedLv.scorePercent = 0.6f;
        serviceAttitudeLv.scorePercent = 0.6f;
    }
    return self;
}
- (void)setup
{
    UILabel * titleLabel = [[UILabel alloc] initWithText:@"店铺评分"];
    titleLabel.textColor = [UIColor colorWithString:@"#333333"];
    titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(16)];
    UILabel * descriptionMatch = [[UILabel alloc] initWithText:@"描述相符"];
    UILabel * deliverySpeed = [[UILabel alloc] initWithText:@"发货速度"];
    UILabel * serviceAttitude = [[UILabel alloc] initWithText:@"服务态度"];
    descriptionMatch.textAlignment = NSTextAlignmentLeft;
    deliverySpeed.textAlignment = NSTextAlignmentLeft;
    serviceAttitude.textAlignment = NSTextAlignmentLeft;
    descriptionMatch.textColor = titleLabel.textColor;
    deliverySpeed.textColor = titleLabel.textColor;
    serviceAttitude.textColor = titleLabel.textColor;
    descriptionMatchLv = [[EvaluationView alloc] init];
    deliverySpeedLv = [[EvaluationView alloc] init];
    serviceAttitudeLv = [[EvaluationView alloc] init];
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:descriptionMatch];
    [self.contentView addSubview:deliverySpeed];
    [self.contentView addSubview:serviceAttitude];
    [self.contentView addSubview:descriptionMatchLv];
    [self.contentView addSubview:deliverySpeedLv];
    [self.contentView addSubview:serviceAttitudeLv];
    __weak typeof(self) weakSelf = self;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(15));
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
    }];
    [descriptionMatch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(kScaleHeight(15));
        make.width.mas_equalTo(kScaleWidth(60));
    }];
    [deliverySpeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.top.equalTo(descriptionMatch.mas_bottom).mas_offset(17);
        make.width.equalTo(descriptionMatch.mas_width);
    }];
    [serviceAttitude mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_left);
        make.top.equalTo(deliverySpeed.mas_bottom).mas_offset(17);
        make.width.equalTo(descriptionMatch.mas_width);

    }];
    [descriptionMatchLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(descriptionMatch.mas_right).mas_offset(kScaleWidth(40));
        make.centerY.equalTo(descriptionMatch);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(30));
    }];
    [deliverySpeedLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deliverySpeed.mas_right).mas_offset(kScaleWidth(40));
        make.centerY.equalTo(deliverySpeed);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(30));
    }];
    [serviceAttitudeLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(serviceAttitude.mas_right).mas_offset(kScaleWidth(40));
        make.centerY.equalTo(serviceAttitude);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(30));
    }];
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= kScaleHeight(10);
    [super setFrame:frame];
}
- (CGFloat)descriptionMatch
{
    return descriptionMatchLv.scorePercent;
}
- (CGFloat)deliverySpeed
{
    return deliverySpeedLv.scorePercent;
}
- (CGFloat)serviceAttitude
{
    return serviceAttitudeLv.scorePercent;
}
@end
