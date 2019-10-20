//
//  RefundApplyView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RefundApplyView.h"
@interface RefundApplyView ()

{
    UILabel * _promptLabel;
    UITextView * _textView;
}
@end
@implementation RefundApplyView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _promptLabel = [[UILabel alloc] initWithText:nil];
        _textView = [[UITextView alloc] init];
        
        [self.contentView addSubview:_textView];
        [self.contentView addSubview:_promptLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    
    _promptLabel.textColor = self.titleLabel.textColor;
    _textView.layer.cornerRadius = 2;
    _textView.layer.borderWidth = 0.5f;
    _textView.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
  
    
    __weak typeof(self) weakSelf = self;
  
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(kScaleHeight(15));
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(20));
        make.height.mas_greaterThanOrEqualTo(kScaleHeight(20));
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
        make.bottom.equalTo(weakSelf.cancel.mas_top).mas_offset(-kScaleHeight(20));
        make.top.equalTo(_promptLabel.mas_bottom).mas_offset(kScaleHeight(5));
        make.height.mas_equalTo(kScaleHeight(100));
    }];

    self.titleLabel.text = LaguageControl(@"申请退款");
    _promptLabel.text = LaguageControlAppend(@"退款原因");
  
}
-(void)GetResultBlock:(ResultBlock)block{
    self.block = block;
}

- (void)sureEvent
{
    
    if (_textView.text.length == 0) {
        [HUDManager showWarningWithText:@"请填写退款原因"];
        return;
    }
    if (self.block)
    {
        self.block(_textView.text);
    }
    if([self.delegate respondsToSelector:@selector(baseOrderPop:content:)])
    {
        [self.delegate baseOrderPop:self content:_textView.text];
    }
    [self removeFromWindow];
}
@end
