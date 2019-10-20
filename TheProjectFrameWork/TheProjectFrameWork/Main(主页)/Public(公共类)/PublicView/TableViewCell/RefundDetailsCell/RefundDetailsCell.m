//
//  RefundDetailsCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RefundDetailsCell.h"
#import "ArefundOrderDetailViewModel.h"

@implementation RefundAmountCell
{
    UILabel * prompt;
    UILabel * amountLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        prompt = [[UILabel alloc] init]; //14 #333333
        amountLabel = [[UILabel alloc] init]; // 14 #c90c1e
        prompt.textColor = [UIColor colorWithString:@"#333333"];
        prompt.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        amountLabel.textColor = [UIColor colorWithString:@"#c90c1e"];
        amountLabel.font = prompt.font;
        [self.contentView addSubview:prompt];
        [self.contentView addSubview:amountLabel];
        __weak typeof(self) weakSelf = self;
        [prompt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
            make.centerY.equalTo(weakSelf.contentView);
        }];
        [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(prompt.mas_right).mas_offset(kScaleWidth(15));
            make.centerY.equalTo(weakSelf.contentView);
        }];
        prompt.text = LaguageControl(@"退款金额");
    }
    return self;
}
- (void)setAmount:(NSString *)amount
{
    _amount = amount;
    amountLabel.text = [@"¥" stringByAppendingString: amount?:@""];
}
@end

@implementation RefundDetailsCell
{
    UILabel * operationLabel; // 操作
    UILabel * dateLabel; // 时间
    UILabel *
    correspondOperationLabel; // 对应操作
    UILabel * causeLabel; // 拒绝/退款原因
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        operationLabel = [[UILabel alloc] init];
        dateLabel = [[UILabel alloc] init];
        correspondOperationLabel = [[UILabel alloc] init];
        causeLabel = [[UILabel alloc] init];
        [self.backView addSubview:operationLabel];
        [self.backView addSubview:dateLabel];
        [self.backView addSubview:correspondOperationLabel];
        [self.backView addSubview:causeLabel];
        [self setep];
    }
    return self;
}
- (void)setep
{
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithString:@"#cccccc"];
    [self.backView addSubview:line];
    operationLabel.textColor = [UIColor colorWithString:@"#999999"]; // 14 #999999
    operationLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    dateLabel.textColor = operationLabel.textColor;
    dateLabel.font = operationLabel.font;
    causeLabel.numberOfLines = 2; // 14 #333333
    causeLabel.font = operationLabel.font;
    correspondOperationLabel.font = operationLabel.font;
    causeLabel.textColor = [UIColor colorWithString:@"#333333"];
    correspondOperationLabel.textColor = causeLabel.textColor;
    __weak typeof(self.backView) weakSelf = self.backView;
    [operationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(15));
    }];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
        make.top.equalTo(operationLabel.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
        make.height.mas_equalTo(kScaleHeight(0.7));
        make.top.equalTo(dateLabel.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [correspondOperationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
        make.top.equalTo(line.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [causeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(12));
        make.top.equalTo(correspondOperationLabel.mas_bottom).mas_offset(kScaleHeight(10));
    }];

}
- (void)setModel:(RefundDetailDerailModel *)model
{
    _model = model;
    operationLabel.text = model.operate;
    dateLabel.text = model.time;
    causeLabel.text = model.reasonInfo;
    correspondOperationLabel.text = model.reason;
}
@end
