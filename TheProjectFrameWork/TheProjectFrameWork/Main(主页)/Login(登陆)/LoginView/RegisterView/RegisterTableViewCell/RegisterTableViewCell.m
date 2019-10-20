//
//  RegisterTableViewCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RegisterTableViewCell.h"
/**
 *  cell 上下间距
 */
#define kCellMargin 13
@interface RegisterTableViewCell ()
{
    UILabel * _textLabel;
    UILabel * _detailLabel;
    UILabel * _phoneLabel;
}
@end
@implementation RegisterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _textLabel = [[UILabel alloc] initWithText:nil];
        _detailLabel = [[UILabel alloc] initWithText:nil];
        _phoneLabel = [[UILabel alloc] initWithText:nil];
        [self.contentView addSubview:_textLabel];
        [self.contentView addSubview:_detailLabel];
        [self.contentView addSubview:_phoneLabel];
        [self setup];
    }
    return self;
}

- (void)setup
{
    _textLabel.font = [UIFont fontWithName:@"Heiti SC" size:kAppAsiaFontSize(16)];
    _textLabel.textColor = [UIColor blackColor];
    _detailLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
    _detailLabel.textColor = [UIColor colorWithString:@"#a3a3a3"];
    _phoneLabel.textColor = kNavigationColor;
    __weak typeof(self) weakSelf = self;
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.contentView).mas_offset(kScaleHeight(8));
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(8));
        make.left.equalTo(_textLabel.mas_left);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textLabel.mas_top);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(8));
    }];
}

- (void)setText:(NSString *)text detailText:(NSString *)detailText
{
    _textLabel.text = LaguageControl(text);
    _detailLabel.text = LaguageControl(detailText);
}
- (void)setText:(NSString *)text detailText:(NSString *)detailText phone:(NSString *)phone
{
    [self setText:text detailText:detailText];
    _phoneLabel.text = phone;
}
/**
 *  修改上下间距
 *
 *  @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= kScaleHeight(kCellMargin);
    frame.origin.y += kScaleHeight(kCellMargin);
    
    [super setFrame:frame];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [[UIColor colorWithString:@"#a3a3a3120"] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextStrokePath(ctx);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end
