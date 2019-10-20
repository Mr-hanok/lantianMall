//
//  UserAgreementButton.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  提示用户是否阅读协议

#import "UserAgreementButton.h"
@interface UserAgreementButton ()<UITextViewDelegate>
{
    UITextView * _textView;
    UIButton * _sender;
    NSMutableAttributedString * _contentString;
}
@end
@implementation UserAgreementButton
- (instancetype)initWithTitle:(NSString *)title
                      keyWord:(NSString *)keyword
{
    self = [super init];
    if(self)
    {
        _contentString = [[NSMutableAttributedString alloc] initWithString:title];
        [_contentString addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"username://"] range:[[_contentString string] rangeOfString:keyword]];
        _textView.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        _textView.text = title;
        _textView.attributedText = _contentString;
        [self layoutIfNeeded];
        CGRect tmpRect = [title boundingRectWithSize:CGSizeMake(KScreenBoundWidth * 0.9f, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_textView.font} context:nil];
        _height = tmpRect.size.height;
        _textView.textContainerInset = UIEdgeInsetsMake(2, 0, 2, 0);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        _textView = [[UITextView alloc] init];
        _sender = [UIButton buttonWithType:UIButtonTypeCustom];
        _sender.imageView.contentMode = UIViewContentModeCenter;
        [_sender setBackgroundImage:[UIImage imageNamed:@"selectedAgreement"] forState:UIControlStateSelected];
        [_sender setBackgroundImage:[UIImage imageNamed:@"normalAgreement"] forState:UIControlStateNormal];
        _sender.selected = YES;
        
        [self addSubview:_textView];
        [self addSubview:_sender];
        
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.dataDetectorTypes = UIDataDetectorTypeCalendarEvent;
        _textView.backgroundColor = [UIColor clearColor];
        [_sender addTarget:self action:@selector(userAgreementWithButton:) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        [_sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.centerY.equalTo(_textView);
        }];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_sender.mas_right);
            make.top.bottom.right.equalTo(weakSelf);
        }];
        
    }
    return self;
}
#pragma mark - textviewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
   if([_delegate respondsToSelector:@selector(userAgreementRedirect)])
   {
       [_delegate userAgreementRedirect];
   }
    return NO;
}

- (void)userAgreementWithButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if([_delegate respondsToSelector:@selector(userAgreementClickWithButton:)])
    {
        [_delegate userAgreementClickWithButton:sender];
    }
}
#pragma mark - setter and getter
- (void)setText:(NSString *)text
{
    _text = text;
    _contentString = [[NSMutableAttributedString alloc] initWithString:text];
}
- (void)setKeyWord:(NSString *)keyWord
{
    _keyWord = keyWord;
    [_contentString addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"username://"] range:[[_contentString string] rangeOfString:keyWord]];
    _textView.attributedText = _contentString;
}
- (BOOL)isSelected
{
    return _sender.selected;
}
@end
