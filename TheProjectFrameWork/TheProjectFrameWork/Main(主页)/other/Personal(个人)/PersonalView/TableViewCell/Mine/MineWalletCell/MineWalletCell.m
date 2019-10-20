//
//  MineWalletCell.m
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineWalletCell.h"
@interface MineWalletCell ()
{
    UIImageView * _imageView;
    UILabel * _describeLabel;
    UILabel * _valueLabel;
}
@end
@implementation MineWalletCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        UIImageView * more = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
        _imageView = [[UIImageView alloc] init];
        _describeLabel = [[UILabel alloc] initWithText:nil];
        _valueLabel = [[UILabel alloc] initWithText:nil];
        _imageView.contentMode = UIViewContentModeCenter;
        _describeLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(16)];
        _valueLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _describeLabel.textColor = [UIColor blackColor];
        _valueLabel.textColor = [UIColor orangeColor];
        _describeLabel.numberOfLines = 0;
        [self.backView addSubview:_imageView];
        [self.backView addSubview:_describeLabel];
        [self.backView addSubview:_valueLabel];
        [self.backView addSubview:more];
        __weak __typeof__(self) weakSelf = self;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(weakSelf.backView).mas_offset(kScaleWidth(8));
            make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleWidth(5));
            make.width.equalTo(_imageView.mas_height);
        }];
        [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.backView);
            make.right.lessThanOrEqualTo(_valueLabel.mas_left).mas_offset(kScaleWidth(10));
            make.left.equalTo(_imageView.mas_right).mas_offset(kScaleWidth(5));
        }];
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.backView);
            make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(10));
            make.width.greaterThanOrEqualTo(weakSelf.backView.mas_width).multipliedBy(0.28f);
        }];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.backView);
            make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(5));
        }];
        _valueLabel.backgroundColor = [UIColor clearColor];
        _describeLabel.backgroundColor = [UIColor clearColor];
        _imageView.backgroundColor = [UIColor clearColor];
         
         }
    
    return self;
}



- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}
- (void)setTitle:(NSString *)title
{
    _title = [LaguageControl languageWithString:title];
    _describeLabel.text = [LaguageControl languageWithString:title];
}
- (void)setValue:(NSString *)value
{
    _value = value;
    _valueLabel.text = value;
}
@end
