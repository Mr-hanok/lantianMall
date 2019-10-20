//
//  MineShopBaseCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopBaseCell.h"

@implementation MineShopBaseCell
{
    UILabel * _titleLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
       
        UILabel * title = [[UILabel alloc] init];
        UIView * line = [UIView new];
        [self.backView addSubview:title];
        [self.backView addSubview:line];
        __weak typeof(self) weakSelf = self;

        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(10));
            make.height.mas_equalTo(kScaleHeight(25));
            make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(14));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).mas_offset(kScaleWidth(15));
            make.right.left.equalTo(weakSelf.backView);
            make.height.mas_equalTo(0.5f);
        }];
        title.font = [UIFont fontWithName:@"Thonburi-Bold" size:13];
        title.textColor = [UIColor colorWithString:@"#333333"];
        line.backgroundColor = [UIColor colorWithString:@"#cccccc"];
        _line = line;
        _titleLabel = title;

    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
@end

@implementation MineShopManagerItem
{
    UIImageView * _image;
    UILabel * _item;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _image = [[UIImageView alloc] init];
        _item = [[UILabel alloc] init];
        _image.contentMode = UIViewContentModeCenter;
        _item.textAlignment = NSTextAlignmentLeft;
        _item.textColor = [UIColor colorWithString:@"#333333"];
        _item.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        [self addSubview:_image];
        [self addSubview:_item];
        __weak typeof(self) weakSelf = self;
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(weakSelf);
        }];
        [_item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(8));
        }];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
{
    self = [super init];
    if(self)
    {
        _image.image = image;
        _item.text = title;
        
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(mineShopManagerItem:)])
    {
        [_delegate mineShopManagerItem:self];
    }
}
@end
