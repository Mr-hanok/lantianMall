//
//  PublishMessageView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PublishMessageView.h"
@interface PublishMessageView ()<UITextViewDelegate>
@end
@implementation PublishMessageView
{
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithString:@"#cccccc"];
        UITextView * textField = [[UITextView alloc] init];
        textField.layer.borderColor = [UIColor clearColor].CGColor;
        textField.layer.cornerRadius = 3;
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:kAppAsiaFontSize(20)];
        textField.delegate = self;
        [self addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kScaleHeight(4), 5, kScaleHeight(4), 5)).priority(750);
        }];
        _textField = textField;
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        if([_delegate respondsToSelector:@selector(pulishMessageComplete:)])
        {
            [_delegate pulishMessageComplete:textView.text];
        }
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    CGFloat maxHeight = kScaleHeight(120);
    CGRect frame = textView.frame;
    CGSize constraintSize = (CGSize){frame.size.width, MAXFLOAT};
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <= frame.size.height) {
        
        size.height = frame.size.height;
        
    }else{
        if (size.height >= maxHeight)
        {
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }

    [UIView animateWithDuration:0.25f animations:^{
        textView.frame = (CGRect){frame.origin.x, frame.origin.y, frame.size.width, size.height};
    }];
}

@end
