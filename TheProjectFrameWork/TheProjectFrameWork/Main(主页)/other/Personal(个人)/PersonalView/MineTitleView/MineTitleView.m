//
//  MineTitleView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineTitleView.h"
@interface MineTitleView ()
{
    UIImageView * imageV;
    UILabel * titleLabel;
}
@end

@implementation MineTitleView
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
{
    self = [super init];
    if(self)
    {
        _title = title;
        _image = image;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        imageV = [[UIImageView alloc] initWithImage:self.image];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        titleLabel = [[UILabel alloc] initWithText:self.title];
        titleLabel.font = [UIFont boldSystemFontOfSize:kAppAsiaFontSize(13)];
        titleLabel.textColor = [UIColor blackColor];
        UIImageView * accessory = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]];
        [self addSubview:imageV];
        [self addSubview:titleLabel];
        [self addSubview:accessory];
        __weak typeof(self) weakSelf = self;
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(weakSelf).mas_offset(kScaleWidth(8));
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(5));
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).mas_offset(kScaleWidth(8));
            make.top.equalTo(weakSelf.mas_top);
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
        [accessory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(15));
        }];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(mineTitleViewClick:)])
    {
        [_delegate mineTitleViewClick:self];
    }
}

- (void)setImage:(UIImage *)image
{
    imageV.image = image;
}
- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc120"] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end
