//
//  TextFieldTableCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "TextFieldTableCell.h"
@interface TextFieldTableCell ()<UITextFieldDelegate>
{
    UITextField * _textField;
}
@end
@implementation TextFieldTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _textField = [[UITextField alloc] init];
        [self.contentView addSubview:_textField];
        __weak typeof(self) weakSelf = self;
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView).mas_offset(UIEdgeInsetsMake(0, 10, 0, 0));
        }];
        _textField.delegate = self;
    }
    return self;
}
- (void)loadTextFieldTag:(NSInteger)tag placeholder:(NSString *)placeholder
{
    _textField.placeholder = LaguageControl(placeholder);
    _textField.tag = tag;
    _textField.secureTextEntry = YES;
}
#pragma mark - textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangeValue) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textFieldChangeValue
{
    _text = _textField.text;
    if([_delegate respondsToSelector:@selector(textFieldValueChange:)])
    {
        [_delegate textFieldValueChange:_textField];
    }
}



@end
