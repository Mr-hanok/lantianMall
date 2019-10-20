//
//  PlaceholderTextView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PlaceholderTextView.h"
@interface PlaceholderTextView ()<UITextViewDelegate>
{
    UILabel * _placeholderLabel;
    UITextView * _textView;
}
@end
@implementation PlaceholderTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _placeholderLabel = [[UILabel alloc] initWithText:nil];
        _placeholderLabel.textColor = [UIColor colorWithString:@"#a3a3a3180"];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        [self addSubview:_textView];
        [self addSubview:_placeholderLabel];
        __weak typeof(self) weakSelf = self;
        _textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleHeight(5));
            make.top.equalTo(weakSelf.mas_top);
            make.right.equalTo(weakSelf.mas_right).priority(750);
        }];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        
        self.backgroundColor = [UIColor clearColor];
        _placeholderLabel.backgroundColor = self.backgroundColor;
        _textView.backgroundColor = self.backgroundColor;
       
        self.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        
    }
    return self;
}
#pragma mark - textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.textInputMode.primaryLanguage == NULL ||[textView.textInputMode.primaryLanguage isEqualToString:@"emoji"])
    {
        [HUDManager showWarningWithText:@"不支持发送表情~"];
        return NO;
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChangeValue) name:UITextViewTextDidChangeNotification object:textView];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textViewChangeValue
{
    _placeholderLabel.hidden = _textView.hasText;
    if([_delegate respondsToSelector:@selector(placeholderTextViewContent:)])
    {
        [_delegate placeholderTextViewContent:_textView.text];
    }
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = LaguageControl(placeholder);
    _placeholderLabel.text = LaguageControl(placeholder);
    _placeholderLabel.font = _textView.font;
}
- (void)setFont:(UIFont *)font
{
    _placeholderLabel.font = font;
    _textView.font = font;
}
- (void)setText:(NSString *)text
{
    _text = text;
    if(text.length != 0)
    {
    _placeholderLabel.hidden = YES;
    }
    _textView.text = text;
}

@end
