//
//  OtherButton.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OtherButton.h"
@interface OtherButton ()
{
    UILabel * _label;
    UIImageView * _image;
}
@end
@implementation OtherButton
- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)color
                        image:(UIImage *)image
{
    self = [super init];
    if(self){
        self.userInteractionEnabled = YES;
        _label = [UILabel new];
        _image = [UIImageView new];
        _image.image = image;
        _label.text = title;
        _label.textColor = color;
        _label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        [self addSubview:_image];
        [self setup];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([self.delegate respondsToSelector:@selector(clickButtonWithTitle:)])
    {
        [self.delegate clickButtonWithTitle:_label.text];
    }
}
- (void)setup
{
    
    __weak typeof(self) weakSelf = self;
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.lessThanOrEqualTo(weakSelf.mas_top).mas_offset(kScaleHeight(5));
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(_label.mas_top).mas_offset(-kScaleHeight(12));
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf);
    }];
}
@end
