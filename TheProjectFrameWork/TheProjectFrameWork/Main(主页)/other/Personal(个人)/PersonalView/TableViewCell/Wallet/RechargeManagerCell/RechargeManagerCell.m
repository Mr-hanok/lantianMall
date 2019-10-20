//
//  RechargeManagerCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RechargeManagerCell.h"
#import "NSString+OrderStatus.h"
#import "RechargeManagerModel.h"
@interface RechargeManagerCell ()
{
    UILabel * _sumLabel;
    UILabel * _modeLabel;
    UILabel * _dateLabel;
    UILabel * _rechargeStateLabel;
    UILabel * _payStateLabel;
    
}
@end
@implementation RechargeManagerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        UIView * back = [[UIView alloc] init];
        
        back.backgroundColor = [UIColor clearColor];
        self.multipleSelectionBackgroundView = back;
        UIView * left = [UIView new];
        UIView * right = [UIView new];
        [self.contentView addSubview:left];
        [self.contentView addSubview:right];
        __weak typeof(self) weakSelf = self;
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(weakSelf.contentView);
            make.width.equalTo(right.mas_width);
        }];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(weakSelf.contentView);
            make.left.equalTo(left.mas_right);
        }];

        _sumLabel = [[UILabel alloc] initWithText:nil];
        _modeLabel = [[UILabel alloc] initWithText:nil];
        _dateLabel = [[UILabel alloc] initWithText:nil];
        _rechargeStateLabel = [[UILabel alloc] initWithText:nil];
        _payStateLabel = [[UILabel alloc] initWithText:nil];
        _payStateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        [left addSubview:_sumLabel];
        [left addSubview:_modeLabel];
        [left addSubview:_dateLabel];
        [right addSubview:_rechargeStateLabel];
        [right addSubview:_payStateLabel];

        [self setup];
    }
    return self;
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    [self setNeedsDisplay];
}
- (void)setup
{
    UIColor * color = [UIColor colorWithString:@"#666666"];
    _sumLabel.textColor = color;
    _modeLabel.textColor = color;
    _dateLabel.textColor = color;
    _rechargeStateLabel.textColor = color;
    _payStateLabel.textColor = color;
    _modeLabel.textAlignment = NSTextAlignmentLeft;
    __weak typeof(_sumLabel.superview) left = _sumLabel.superview;
    __weak typeof(self.contentView) weakSelf = self.contentView;
    [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(left).mas_offset(kScaleWidth(10));
    }];
    [_modeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sumLabel.mas_left);
//        make.top.equalTo(_sumLabel.mas_bottom).mas_offset(kScaleHeight(10));
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(10));
        make.right.equalTo(_payStateLabel.mas_left).mas_offset(-kScaleWidth(10));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rechargeStateLabel.mas_left);
        make.top.equalTo(_sumLabel.mas_top);
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
    }];
    __weak typeof(_rechargeStateLabel.superview) right = _rechargeStateLabel.superview;
    [_rechargeStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(right).mas_offset(kScaleWidth(10));
    }];
    [_payStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rechargeStateLabel.mas_left);
        make.top.equalTo(_modeLabel.mas_top);
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
    }];

}
- (void)setModel:(RechargeManagerModel *)model
{
    _model = model;
    _sumLabel.text = [NSString stringWithFormat:@"%@: ￥%.2f",[LaguageControl languageWithString:@"充值金额"],model.sum];
    _modeLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"支付方式"],[LaguageControl languageWithString:model.payMode]];
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"充值时间"],model.date];
//    _rechargeStateLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"充值状态"],LaguageControl(@"完成")];
    _payStateLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"支付状态"],[NSString orderStatus:model.mobile_pay_status]];
    
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= kScaleHeight(10);
    frame.origin.y += kScaleHeight(10);
    [super setFrame:frame];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.selectionStyle = editing?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
}
@end
