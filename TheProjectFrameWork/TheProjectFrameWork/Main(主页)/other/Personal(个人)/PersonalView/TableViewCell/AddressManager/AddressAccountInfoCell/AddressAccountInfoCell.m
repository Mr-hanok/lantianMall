//
//  AddressAccountInfoCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddressAccountInfoCell.h"
@interface AddressAccountInfoCell ()<UITextFieldDelegate>
{
    UILabel * _titleLabel;
    UITextField * _infoTextField;
}
@end
@implementation AddressAccountInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _infoTextField = [[UITextField alloc] init];
        _infoTextField.delegate = self;
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_infoTextField];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
            make.top.bottom.equalTo(weakSelf.contentView);
            make.right.equalTo(_infoTextField.mas_left).mas_offset(kScaleWidth(5));
        }];
        [_infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.contentView.mas_width).multipliedBy(0.7f);
            make.top.bottom.right.equalTo(weakSelf.contentView);
        }];

    }
    return self;
}
#pragma mark - textField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChange) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textFieldValueChange
{
    if([_delegate respondsToSelector:@selector(addrssAccountWithIndex:textField:)])
    {
        [_delegate addrssAccountWithIndex:_index textField:_infoTextField];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
- (void)setText:(NSString *)text
{
    _text = text;
    _infoTextField.text = text;
}
@end
