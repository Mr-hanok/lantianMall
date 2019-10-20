//
//  WalletDetailsCell.m
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  钱包详情对应cell

#import "WalletDetailsCell.h"
#import "AccountBalanceModel.h"
#import "MineRebateModel.h"
#import "NSString+OrderStatus.h"

@interface WalletDetailsCell ()
{
    UILabel * _typeLabel;
    UILabel * _balanceLabel;
    UILabel * _dateLabel;
    UILabel * _valueLabel;
}
@end
@implementation WalletDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _typeLabel = [[UILabel alloc] initWithText:nil];
        _balanceLabel = [[UILabel alloc] initWithText:nil];
        _dateLabel = [[UILabel alloc] initWithText:nil];
        _valueLabel = [[UILabel alloc] initWithText:nil];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_typeLabel];
        [self.contentView addSubview:_balanceLabel];
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_valueLabel];
        __weak __typeof__(self) weakSelf = self;
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(weakSelf.contentView).mas_offset(kScaleWidth(10));
            make.right.equalTo(_dateLabel.mas_left).mas_offset(kScaleWidth(10));
        }];
        [_balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleWidth(10));
        }];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).mas_offset(kScaleWidth(10));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
            make.width.mas_equalTo(kScaleWidth(100));
        }];
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleWidth(10));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
        }];
        _typeLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        _typeLabel.textColor = [UIColor darkGrayColor];
        _dateLabel.textColor = [UIColor darkGrayColor];
        _balanceLabel.textColor = [UIColor grayColor];
        _valueLabel.textColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)setBalanceModel:(id)balanceModel
{
    
    if([balanceModel isKindOfClass:[AccountBalanceModel class]])
    {
        AccountBalanceModel * model = balanceModel;
        if (self.isGold) {
            if ( [model.gl_count isEqualToString:@"0"]||model.gl_count == nil) {
                _valueLabel.text = [NSString stringWithFormat:@"%@: %@",LaguageControl(@"金币"),model.gl_money];
            }else{
                _valueLabel.text = [NSString stringWithFormat:@"%@: %@",LaguageControl(@"金币"),model.gl_count];

            }
            _dateLabel.text = model.addTime;
            _typeLabel.text = model.gl_content;
            
        }else{
            _valueLabel.text = model.pd_log_amount;
            _dateLabel.text = model.addTime;
            _typeLabel.text = model.payTypeStr?:model.pd_log_info;
            _balanceLabel.text = [NSString balanceStatus:model.status];
        }
    }else
    {// 返利
        MineRebateModel * model = balanceModel;
        _valueLabel.text = model.rebatePrice;
        _typeLabel.text = model.addTime;
    }
   
}
-(void)setIsGold:(BOOL)isGold{
    _isGold = isGold;
}
//- (void)setFrame:(CGRect)frame
//{
//    frame.size.height -= kScaleHeight(10);
//    frame.origin.y += kScaleHeight(10);
//    [super setFrame:frame];
//}
@end
