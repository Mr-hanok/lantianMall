//
//  AllOrderAccessoryView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AllOrderAccessoryView.h"
@interface AllOrderAccessoryView ()
{
    UILabel * _label;
}
@end
@implementation AllOrderAccessoryView
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if(self)
    {
        _label.text = title;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _label = [[UILabel alloc] initWithText:nil];
        _label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(10)];
        _label.textColor = [UIColor grayColor];
        _label.textAlignment = NSTextAlignmentRight;
        UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]];
        [self addSubview:_label];
        [self addSubview:image];
        __weak typeof(self) weakSelf = self;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(weakSelf);
            make.right.equalTo(image.mas_left).mas_offset(-5);
        }];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-5);
        }];
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _label.text = title;
}
@end
