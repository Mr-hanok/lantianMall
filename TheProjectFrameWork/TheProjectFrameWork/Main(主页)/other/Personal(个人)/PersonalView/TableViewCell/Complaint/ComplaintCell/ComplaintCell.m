//
//  ComplaintCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintCell.h"
#import "ComplaintModel.h"
#import "NSString+ComplaintsStatus.h"
/*
 title; ///< 投诉主题
 
 date;  ///< 投诉时间
 
 state; ///< 投诉状态
 
 plaintiff; ///< 投诉人
 
 defendant; ///< 被投诉人
 
 describe;  ///< 问题描述
 */
@interface ComplaintCell ()
{
    UILabel * _titleLabel;
    UILabel * _dateLabel;
    UILabel * _stateLabel;
    UILabel * _plaintiffLabel;
    UILabel * _defendantLabel;
    UILabel * _describeLabel;
}
@end
@implementation ComplaintCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _dateLabel = [[UILabel alloc] initWithText:nil];
        _stateLabel = [[UILabel alloc] initWithText:nil];
        _plaintiffLabel = [[UILabel alloc] initWithText:nil];
        _defendantLabel = [[UILabel alloc] initWithText:nil];
        _describeLabel = [[UILabel alloc] initWithText:nil];
        _plaintiffLabel.textAlignment = NSTextAlignmentLeft;
        _describeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_stateLabel];
        [self.contentView addSubview:_plaintiffLabel];
        [self.contentView addSubview:_defendantLabel];
        [self.contentView addSubview:_describeLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
    _dateLabel.textColor = [UIColor colorWithString:@"#666666"];
    _stateLabel.textColor = [UIColor colorWithString:@"#ed5f61"];
    _plaintiffLabel.textColor = _titleLabel.textColor;
    _defendantLabel.textColor = _titleLabel.textColor;
    _describeLabel.textColor = _titleLabel.textColor;
    _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(11)];
    _stateLabel.font = _titleLabel.font;
    _dateLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(10)];
    _defendantLabel.textAlignment = NSTextAlignmentLeft;
    UIView * line = [UIView new];
    line.backgroundColor = [UIColor colorWithString:@"#cacbcc120"];
    [self.contentView addSubview:line];
    __weak typeof(self) weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(7));
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(5));
        make.height.mas_lessThanOrEqualTo(kScaleHeight(25));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(5));
        make.top.equalTo(_titleLabel.mas_bottom).mas_offset(kScaleHeight(7));
        make.height.mas_lessThanOrEqualTo(kScaleHeight(20));
    }];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(7));
        make.top.bottom.equalTo(_titleLabel);
        make.height.mas_lessThanOrEqualTo(kScaleHeight(25));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(7));
        make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(7));
        make.height.mas_equalTo(@1);
        make.top.equalTo(_dateLabel.mas_bottom).mas_equalTo(kScaleHeight(4));
    }];
    [_plaintiffLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(5));
        make.top.equalTo(line.mas_bottom).mas_offset(kScaleHeight(7));
        make.height.mas_lessThanOrEqualTo(kScaleHeight(25));
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
    }];
    [_defendantLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_plaintiffLabel.mas_left);
        make.top.equalTo(_plaintiffLabel.mas_bottom).mas_offset(kScaleHeight(8));
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
        make.height.mas_lessThanOrEqualTo(kScaleHeight(25));

    }];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(5));
        make.top.equalTo(_defendantLabel.mas_bottom).mas_offset(kScaleHeight(7));
        make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(10)).priority(750);
        make.height.mas_lessThanOrEqualTo(kScaleHeight(25));
        make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(5));
    }];
    
}

#pragma mark - event respond
- (void)cancelComplaint
{
    if([_delegate respondsToSelector:@selector(complaintCancel:)])
        {
            [_delegate complaintCancel:self];
        }
}
#pragma mark - setter and getter
- (void)setModel:(ComplaintModel *)model
{
    _model = model;
    NSString * status = [NSString ComplaintStatus:model.status];
    //(0 = 新投诉 , 1 = 待申诉 , 2 = 对话中 , 3 = 待仲裁 , 4 = 已完成)
     _dateLabel.text = [NSString stringWithFormat:@"%@: %@",    [LaguageControl languageWithString:@"投诉时间"],model.addTime];
    _stateLabel.text = status;
    _plaintiffLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉人"],model.fromUserName];
    _defendantLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"被投诉人"],model.toUserName];
    _describeLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉内容"],model.describe?model.describe:@""];
    _titleLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉主题"],model.title];
    if([model.fromUserId isEqualToString:kUserId] && model.status != 4)
    {
        self.lastView.tag = 100;
    }else
    {
        [_lastView removeFromSuperview];
    }
    
}

- (UIView *)lastView
{

    if(!_lastView)
    {
        __weak typeof(self) weakSelf = self;
        UIView * last = [UIView new];
        UIButton * cancelSender = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView * line = [UIView new];
        line.backgroundColor = [UIColor colorWithString:@"#cacbcc120"];
        cancelSender.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelSender setTitle:[LaguageControl languageWithString:@"取消投诉"] forState:UIControlStateNormal];
        cancelSender.layer.borderWidth = 1;
        cancelSender.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
        cancelSender.layer.cornerRadius = 3;
        [cancelSender setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
        [cancelSender addTarget:self action:@selector(cancelComplaint) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:last];
        [last addSubview:line];
        [last addSubview:cancelSender];
        [last mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(kScaleHeight(44));
            make.top.equalTo(_describeLabel.mas_bottom).mas_equalTo(kScaleHeight(7));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(1);
            make.top.equalTo(last.mas_top);
        }];
        [cancelSender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(last.mas_height).multipliedBy(0.618f);
            make.centerY.equalTo(last);
            make.right.equalTo(last.mas_right).mas_offset(-kScaleWidth(5));
            make.width.mas_equalTo(kScaleWidth(80));
        }];
        
        _lastView = last;
    }
    return _lastView;
}
@end
