//
//  ImageButton.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ImageButton.h"
@interface ImageButton ()
{
    UIImageView * _image;
    UILabel * _titleLabel;
    UIImage * _normalImage;
    UIImage * _selectImage;
}
@end
@implementation ImageButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _image = [[UIImageView alloc] initWithImage:nil];
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _image.contentMode = UIViewContentModeCenter;
        [self addSubview:_image];
        [self addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(weakSelf);
            make.width.mas_equalTo(_image.mas_height);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_image.mas_right).mas_offset(kScaleWidth(5));
            make.top.bottom.right.equalTo(weakSelf);
        }];
    }
    return self;
}
- (void)setImage:(UIImage *)normalImage
     selectImage:(UIImage *)selectImage
           title:(NSString *)title
{
    _normalImage = normalImage;
    if(selectImage)
    {
        _selectImage = selectImage;
    }else
    {
        _selectImage = normalImage;
    }
    _image.image = normalImage;
    _titleLabel.text = [LaguageControl languageWithString:title];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(imageButton:)])
    {
        [_delegate imageButton:self];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = [LaguageControl languageWithString:title];
    _titleLabel.text = [LaguageControl languageWithString:title];
}
- (void)setNowImage:(UIImage *)nowImage
{
    _nowImage = nowImage;
    _image.image = nowImage;
    _selectImage = nowImage;
    _normalImage = nowImage;
}
- (void)setSelect:(BOOL)select
{
    _select = select;
    if(_select)
    {
        _image.image = _selectImage;
        _titleLabel.textColor = _selectTextColor ? _selectTextColor : [UIColor grayColor];
    }else
    {
        _image.image = _normalImage;
        _titleLabel.textColor = [UIColor grayColor];
    }
    
}
@end
