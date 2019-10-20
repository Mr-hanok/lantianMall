//
//  VerifyPayInfoView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "VerifyPayInfoView.h"
@interface VerifyPayInfoView ()
{
    UILabel * _titleLabel;
    UILabel * _contentLabel;
}
@end
@implementation VerifyPayInfoView

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
{
    self = [super init];
    if(self)
    {
        _titleLabel.text = title;
        _contentLabel.text = content;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _contentLabel = [[UILabel alloc] initWithText:nil];
        [self addSubview:_titleLabel];
        [self addSubview:_contentLabel];
        UIColor * textColor = [UIColor colorWithString:@"#666666"];
        _titleLabel.textColor = textColor;
        _contentLabel.textColor = textColor;
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(5));
            make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(10));
        }];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(10));
            make.top.equalTo(_titleLabel.mas_bottom).mas_offset(kScaleHeight(15)).priority(750);
        }];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#CCCCCC"] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextStrokePath(ctx);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end
