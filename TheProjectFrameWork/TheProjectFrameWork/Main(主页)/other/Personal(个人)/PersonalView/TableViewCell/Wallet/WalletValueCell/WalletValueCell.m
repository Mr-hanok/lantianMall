//
//  WalletValueCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "WalletValueCell.h"
@interface WalletValueCell()
{
    UILabel * _titleLabel;
    UILabel * _valueLabel;
}
@end
@implementation WalletValueCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _valueLabel = [[UILabel alloc] initWithText:nil];
        _titleLabel.textColor = [UIColor colorWithString:@"#666666"];
        _valueLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:kAppAsiaFontSize(30)];
        _valueLabel.textColor = [UIColor orangeColor];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_valueLabel];
        
    }
    return self;
}
- (void)loadTitle:(NSString *)title value:(CGFloat)value isViewDetails:(BOOL)details
{
    _titleLabel.text = title;
    _valueLabel.text = [NSString stringWithFormat:@"%.2f",value];
    __weak typeof(self) weakSelf = self;
    UIButton * sender;
    if(details)
    {
        sender = [UIButton buttonWithType:UIButtonTypeCustom];
        [sender setTitle:@"明细 >>" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        [sender addTarget:self action:@selector(viewDetails) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(5));
            make.height.equalTo(_valueLabel.mas_height).mas_offset(-kScaleHeight(5));
        }];
        
    }
   
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.contentView).mas_offset(kScaleHeight(15));
    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.contentView);
    }];
    
}
- (void)loadPointsTitle:(NSString *)title value:(CGFloat)value
{
    UIButton * shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:shopButton];
    _titleLabel.text = [LaguageControl languageWithString:title];
    _valueLabel.text = [NSString stringWithFormat:@"%d",(int)value];
    __weak typeof(self) weakSelf = self;
    [shopButton addTarget:self action:@selector(shop) forControlEvents:UIControlEventTouchUpInside];
    [shopButton setTitle:[LaguageControl languageWithString:@"积分商城"] forState:UIControlStateNormal];
    [shopButton setBackgroundImage:[UIImage imageNamed:@"jifenshangcheng"] forState:UIControlStateNormal];
    shopButton.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.contentView).mas_offset(kScaleHeight(15));
    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(50));
    }];
    [shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
        make.height.equalTo(_valueLabel.mas_height).mas_offset(-kScaleHeight(5));
    }];
    
    
    UIButton * detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:detailBtn];
    [detailBtn addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    NSString *titlestr = [[LaguageControl languageWithString:@"积分明细"] stringByAppendingString:@" >>"];
    [detailBtn setTitle:titlestr forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(8));
    }];
    [detailBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
}
- (void)viewDetails
{
    if([_delegate respondsToSelector:@selector(walletValueViewDetails)])
    {
        [_delegate walletValueViewDetails];
    }
}
- (void)shop
{
   if( [_delegate respondsToSelector:@selector(walletValuePointsShop)])
   {
       [_delegate walletValuePointsShop];
   }
}
- (void)detailBtn{
    
    if( [_delegate respondsToSelector:@selector(clickIntegralDetailBtn)])
    {
        [_delegate clickIntegralDetailBtn];
    }

}
@end
