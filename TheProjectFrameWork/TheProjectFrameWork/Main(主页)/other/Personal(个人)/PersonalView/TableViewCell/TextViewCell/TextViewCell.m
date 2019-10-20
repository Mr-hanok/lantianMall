//
//  TextViewCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "TextViewCell.h"
#import "PlaceholderTextView.h"
@interface TextViewCell ()<UITextViewDelegate,PlaceholderTextViewDelegate>
{
    PlaceholderTextView * _textView;
}
@end
@implementation TextViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _textView = [[PlaceholderTextView alloc] init];
        _textView.delegate = self;
        [self.contentView addSubview:_textView];
        __weak typeof(self) weakSelf = self;
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView).mas_equalTo(UIEdgeInsetsMake(kScaleHeight(10), kScaleWidth(10), 0, kScaleWidth(10)));
        }];
        
    }
    return self;
}
- (void)placeholderTextViewContent:(NSString *)content
{
    if( [_delegate respondsToSelector:@selector(textViewCellValueChangeWithText:)])
    {
        [_delegate textViewCellValueChangeWithText:content];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textView.placeholder = placeholder;
}
- (void)setText:(NSString *)text
{
    _text = text;
    _textView.text = text;
}


@end
