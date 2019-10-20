//
//  RebateDetailsCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RebateDetailsCell.h"
#import "RebateDetailsModel.h"
@interface RebateDetailsCell ()
{
    UILabel * _titleLabel;
}
@end
@implementation RebateDetailsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLabel  = [[UILabel alloc] initWithText:nil];
    _titleLabel.text = @"返利明细";
    _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(16)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    return self;
}
- (void)loadDetails:(NSArray *)details
{
    [details enumerateObjectsUsingBlock:^(RebateDetailsModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        RebateDetails * title = [[RebateDetails alloc] init];
        title.date = model.date;
        title.content = model.content;
        title.value = model.value;
        [self.contentView addSubview:title];
    }];
    NSArray * subViews = self.contentView.subviews;
    __block UIView * lastView = nil;
    __weak typeof(self) weakSelf = self;
    [subViews enumerateObjectsUsingBlock:^(UIView * view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView)
            {
                make.right.left.equalTo(weakSelf.contentView);

                if(idx == 1)
                {
                make.top.equalTo(lastView.mas_bottom).mas_offset(kScaleHeight(20));
                }else
                {
                make.top.equalTo(lastView.mas_bottom).mas_offset(kScaleHeight(8));
                }
                
            }else
            {
                make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(8));
                make.right.equalTo(weakSelf.contentView.mas_right);

                make.top.equalTo(weakSelf.contentView.mas_top).mas_offset(kScaleHeight(15));
            }
        }];
        lastView = view;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(15));
    }];
}

@end


@interface RebateDetails ()
{
    UILabel * _dateLabel;
    UILabel * _contentLabel;
    UILabel * _valueLabel;
}
@end

@implementation RebateDetails

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _dateLabel = [[UILabel alloc] initWithText:nil];
        _contentLabel = [[UILabel alloc] initWithText:nil];
        _valueLabel = [[UILabel alloc] initWithText:nil];
        [self addSubview:_dateLabel];
        [self addSubview:_contentLabel];
        [self addSubview:_valueLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    UIFont * font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    UIColor * color = [UIColor blackColor];
    _dateLabel.font = font;
    _contentLabel.font = font;
    _valueLabel.font = font;
    _dateLabel.textColor = color;
    _contentLabel.textColor = color;
    _valueLabel.textColor = color;
    __weak typeof(self) weakSelf = self;
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(5));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(_dateLabel.mas_right).mas_offset(kScaleWidth(5));

    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(5));
    }];
}
- (void)setDate:(NSString *)date
{
    _date = date;
    _dateLabel.text = date;
}
- (void)setContent:(NSString *)content
{
    _content = content;
    _contentLabel.text = content;
}
- (void)setValue:(NSString *)value
{
    _value = value;
    _valueLabel.text = value;
}
@end
