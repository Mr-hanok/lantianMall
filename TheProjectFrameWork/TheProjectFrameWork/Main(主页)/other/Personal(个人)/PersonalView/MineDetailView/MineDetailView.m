//
//  MineDetailView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineDetailView.h"
@interface MineDetailView ()
{
    UILabel * _valueLabel;
    UILabel * _textLabel;
    UILabel * _accessoryView;
}
@end
@implementation MineDetailView
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _valueLabel = [[UILabel alloc] initWithText:nil];
        _textLabel = [[UILabel alloc] initWithText:nil];
        _valueLabel.textColor = [UIColor grayColor];
        _textLabel.textColor = [UIColor grayColor];
        _accessoryView = [[UILabel alloc]initWithText:nil];
        _accessoryView.textColor = [UIColor grayColor];
        _accessoryView.font = [UIFont systemFontOfSize:kAppAsiaFontSize(10)];
        [self addSubview:_valueLabel];
        [self addSubview:_accessoryView];
        [self addSubview:_textLabel];
        __weak typeof(self) weakSelf = self;
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).mas_offset(5);
            make.left.equalTo(weakSelf.mas_left).mas_offset(10);
        }];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-5);
            make.left.equalTo(weakSelf.mas_left).mas_offset(10);
            make.top.equalTo(_valueLabel.mas_bottom).mas_offset(5);
            make.height.equalTo(_valueLabel.mas_height);
        }];
        [_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-15);
        }];
        
        /**vlane label 单击手势*/
        _accessoryView.userInteractionEnabled = YES;
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        [_accessoryView addGestureRecognizer:labelTap];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(mineDetailViewClick:)])
    {
        [_delegate mineDetailViewClick:self];
    }
}
- (void)setValue:(double)value
{
    _value = value;
    if(_isIntegral)
    {
        _valueLabel.text = [NSString stringWithFormat:@"%d",(int)_value];
        
    }else
    {
        _valueLabel.text = [NSString stringWithFormat:@"%.2lf",_value];
    }
}
- (void)setText:(NSString *)text
{
    _text = text;
    _textLabel.text = text;
}
- (void)setAccessoryStr:(NSString *)accessoryStr
{
    _accessoryStr = accessoryStr;
    _accessoryView.text = [NSString stringWithFormat:@"%@ >>",accessoryStr];
}
- (void)setIsIntegral:(BOOL)isIntegral
{
    _isIntegral = isIntegral;
    if(isIntegral)
    {
        _valueLabel.text = [NSString stringWithFormat:@"%d",(int)_value];

    }else
    {
        _valueLabel.text = [NSString stringWithFormat:@"%.2f",_value];
    }
}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    if ([_delegate respondsToSelector:@selector(mineDetailViewAccessoryStrClick:)]) {
        [_delegate mineDetailViewAccessoryStrClick:self];
    }
    
    
    
}
@end
