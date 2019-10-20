//
//  DefaultTableViewCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DefaultTableViewCell.h"
#import "AccountCellModel.h"
@interface DefaultTableViewCell ()
{
    UILabel * _textLabel;
    UILabel * _promptLabel;
    UILabel * _valueLabel;
}
@end
@implementation DefaultTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        _textLabel = [[UILabel alloc] initWithText:nil];
        _textLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.textColor = [UIColor blackColor];
        _promptLabel = [[UILabel alloc] initWithText:nil];
        _promptLabel.font = _textLabel.font;
        _promptLabel.textColor = [UIColor lightGrayColor];
        _valueLabel = [[UILabel alloc] initWithText:nil];
        _valueLabel.font = _textLabel.font;
        _valueLabel.textColor = kNavigationColor;
        [self.contentView addSubview:_textLabel];
        [self.contentView addSubview:_promptLabel];
        [self.contentView addSubview:_valueLabel];
        __weak typeof(self) weakSelf = self;
        void (^layoutBlcok)(MASConstraintMaker *make) = ^(MASConstraintMaker *make){
            make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(8));
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(8));
        };
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           layoutBlcok(make);
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(8));
        }];
        [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            layoutBlcok(make);
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
        }];
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            layoutBlcok(make);
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
        }];
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _textLabel.text = [LaguageControl languageWithString:title];
}
- (void)setPrompt:(NSString *)prompt
{
    _promptLabel.text = [LaguageControl languageWithString:prompt];
}
- (void)setIsAccessory:(BOOL)isAccessory
{
    if(isAccessory) self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
- (void)setValue:(double)value
{
    _valueLabel.text = [NSString stringWithFormat:@"%.2lf",value];
}
- (void)setAlignment:(BOOL)alignment
{
    _alignment = alignment;
    if(alignment && ([LaguageControl shareControl].type == LanguageTypesChinese))
    {
        [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(KScreenBoundWidth * 0.2);
        }];
    }
}
- (void)loadWithModel:(AccountCellModel *)model
{
    _textLabel.text = [LaguageControl languageWithString:model.title];
    _promptLabel.text = [LaguageControl languageWithString:model.prompt];
    NSString * value = model.value==-1?@"":[NSString stringWithFormat:@"%.2lf",model.value];
    _valueLabel.text = value;
    if(model.isAccessory){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
- (void)loadWithTitle:(NSString *)title
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _textLabel.text = [LaguageControl languageWithString:title];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if(_alignment)
    {
        if(!([LaguageControl shareControl].type == LanguageTypesChinese))
        {
            return;
        }
        CGSize size = _textLabel.frame.size;
        NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:_textLabel.text];
        CGSize attributeSize = [attributeString.string sizeWithAttributes:@{NSFontAttributeName:_textLabel.font}];
        NSNumber *wordSpace = [NSNumber numberWithInt:(size.width-attributeSize.width)/(attributeString.length-1)];
        [attributeString addAttribute:NSKernAttributeName value:wordSpace range:NSMakeRange(0, attributeString.length)];
        _textLabel.lineBreakMode = NSLineBreakByClipping;
        _textLabel.attributedText = attributeString;
    }
}
@end
