//
//  CountDownButton.m
//  test
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "CountDownButton.h"
@interface CountDownButton ()
{
    NSTimer * _timer;
    NSInteger _interval;
    UILabel * _label;
    NSInteger _count;
    SEL _clickEvent;
    BOOL _status;
}
@end
@implementation CountDownButton

- (instancetype)initWithInterval:(NSTimeInterval)Interval Target:(id)target Sel:(SEL)event
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 3;
        NSString * defaultTitle = [NSString stringWithFormat:@"%@",[LaguageControl languageWithString:@"发送验证码"]];
        _target = target;
        _count = Interval;
        _clickEvent = event;
        _interval = Interval;
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9f];
        [self addSubview:_label];
        _label.text = defaultTitle;
        _label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _label.lineBreakMode = NSLineBreakByClipping;
        _label.textColor = [UIColor whiteColor];
        self.alpha = 1;
        __weak typeof(self) weakSelf = self;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
    }
    return self;
}

- (void)startTimer
{
    if(_timer.valid)
    {
        return;
    }
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
   
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceInterval) userInfo:nil repeats:YES];
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor lightGrayColor];
    self.alpha = 0.2f;
    _label.textColor = [UIColor colorWithString:@"#666666"];

}
- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
    _status = NO;
    NSString * defaultTitle = [NSString stringWithFormat:@"%@",[LaguageControl languageWithString:@"发送验证码"]];
    _label.text = defaultTitle;
    _interval = _count;
    _label.textColor = [UIColor whiteColor];
    self.alpha = 1;
    self.userInteractionEnabled = YES;
}
- (void)reduceInterval
{
    
    @synchronized(self)
    {
        _interval --;
        _label.text = [NSString stringWithFormat:@"%@%ld(s)",[LaguageControl languageWithString:@"重新获取"],(long)_interval];
        _isStart = YES;
    }
    if(_interval == 0.0f)
    {
        [self invalidateTimer];
        _isStart = NO;
        if([_delegate respondsToSelector:@selector(countDownStop)])
        {
            [_delegate countDownStop];
        }
    }
   
}
- (void)stopTimeing
{
    [self invalidateTimer];
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    _isStart = !userInteractionEnabled;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _status = !_status;
    if(_status)
    {
        //[self startTimer];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_clickEvent];
#pragma clang diagnostic pop
        return;
    }
}

@end
