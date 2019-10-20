//
//  AllorderCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AllorderCell.h"
#import "AllOrderAccessoryView.h"
@interface AllorderCell ()
{
    UIImageView * _image;
    UILabel * _titleLabel;
    AllOrderAccessoryView * _accessory;
}
@end
@implementation AllorderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setup];
    }
    return self;
}
- (void)setup
{
    _image = [[UIImageView alloc] initWithImage:nil];
    _titleLabel = [[UILabel alloc] initWithText:@"我的订单"];
    _titleLabel.font = [UIFont boldSystemFontOfSize:kAppAsiaFontSize(13)];
    
    _accessory = [[AllOrderAccessoryView alloc] initWithTitle:@"查看全部订单"];
    _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
    [self.contentView addSubview:_image];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_accessory];
    __weak typeof(self) weakSelf = self;
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(8));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(8));
    }];
    [_accessory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.contentView).priority(750);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(8));
        make.height.mas_equalTo(kScaleHeight(40));
    }];
}

- (void)loadTitle:(NSString *)title
        accessory:(NSString *)accessory
            image:(UIImage *)image
{
    _titleLabel.text = title;
    _accessory.title = accessory;
    _image.image = image;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(allorderClickEventWithType:)])
    {
        [_delegate allorderClickEventWithType:_type];
    }
}
@end
