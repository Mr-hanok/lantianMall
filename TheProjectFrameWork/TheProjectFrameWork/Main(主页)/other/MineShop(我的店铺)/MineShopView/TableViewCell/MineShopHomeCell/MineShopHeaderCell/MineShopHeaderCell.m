//
//  MineShopHeaderCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  卖家－我的店铺－头cell

#import "MineShopHeaderCell.h"
#import "ShopModel.h"
@interface MineShopHeaderCell ()<MineShopIconDelegate,MineShopHeaderButtonDelegate>
{
    MineShopIcon * _icon;
    UILabel * _name;
    MineShopHeaderButton * _photos;
    MineShopHeaderButton * _account;
}
@end
@implementation MineShopHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        UIImageView * backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minebeijing"]];
        _icon = [[MineShopIcon alloc] init];
        _name = [[UILabel alloc] init];
        _photos = [[MineShopHeaderButton alloc] init];
        _account = [[MineShopHeaderButton alloc] init];
        _photos.delegate = self;
        _account.delegate = self;
        [self.contentView addSubview:backImage];
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_photos];
        [self.contentView addSubview:_account];
        __weak typeof(self) weakSelf = self;
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView);
        }];
        _icon.delegate = self;
        [self setup];
    }
    return self;
}
- (void)setup
{
    __weak typeof(self) weakSelf = self;
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(20));
        make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(20)).priority(750);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(30)).priority(750);
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(60), kScaleWidth(60)));
    }];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_icon);
        make.left.equalTo(_icon.mas_right).mas_offset(kScaleWidth(8));
        make.right.lessThanOrEqualTo(_account.mas_left).mas_offset(10);
    }];
    [_photos mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(30));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(15));
    }];
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(30));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(15));
        make.height.equalTo(_photos.mas_height);
        
    }];
    _icon.layer.cornerRadius = kScaleHeight(30);
    _name.textColor = [UIColor whiteColor];
    _name.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    _photos.title = [LaguageControl languageWithString:@"查看相册"];
    _account.title = [LaguageControl languageWithString:@"账户管理"];
}
- (void)clickMineShopHeader:(MineShopHeaderButton *)sender
{
    if([sender isEqual:_photos])
    {
        [self viewPhotos];
    }
    if([sender isEqual:_account])
    {
        [self accountManager];
    }
}
- (void)settingUserIcon:(UIImage *)icon
{
    _icon.image = icon;
}
- (void)setModel:(ShopModel *)model
{
    _model = model;
    _name.text = model.store_name;
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.store_icon] placeholderImage:[UIImage imageNamed:@"Sellertouxiang"]];
}
- (void)viewPhotos
{
    if([_delegate respondsToSelector:@selector(mineShopHeaderPhotos)])
    {
        [_delegate mineShopHeaderPhotos];
    }
}
- (void)accountManager
{
    if([_delegate respondsToSelector:@selector(mineShopHeaderAccount)])
    {
        [_delegate mineShopHeaderAccount];
    }
}
- (void)mineShopIcon:(MineShopIcon *)icon
{
    if([_delegate respondsToSelector:@selector(mineShopHeader:icon:)])
    {
        [_delegate mineShopHeader:self icon:icon];
    }
}
@end

@implementation MineShopIcon


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.image = [UIImage imageNamed:@"Sellertouxiang"];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor colorWithString:@"#ffffff120"].CGColor;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)setImage:(UIImage *)image
{
    [super setImage:image];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(mineShopIcon:)])
    {
        [_delegate mineShopIcon:self];
    }
}
@end


@implementation MineShopHeaderButton
{
    UILabel * _titleLabel;
    UIImageView * _image;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        _titleLabel.textColor = [UIColor whiteColor];
        _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baisejiantou"]];
        _image.contentMode = UIViewContentModeCenter;
        [self addSubview:_titleLabel];
        [self addSubview:_image];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(6));
        }];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(5));
            make.left.equalTo(_titleLabel.mas_right).mas_offset(kScaleWidth(6));
        }];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(clickMineShopHeader:)])
    {
        [_delegate clickMineShopHeader:self];
    }
}
- (void)setFont:(UIFont *)font
{
    _font = font;
    _titleLabel.font = font;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
@end