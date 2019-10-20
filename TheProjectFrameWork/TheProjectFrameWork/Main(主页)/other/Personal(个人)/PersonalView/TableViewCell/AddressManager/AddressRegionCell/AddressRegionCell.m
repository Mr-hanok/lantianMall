//
//  AddressRegionCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddressRegionCell.h"
@interface AddressRegionCell ()
{
    UILabel * _titleLabel;
    UILabel * _countryLabel;
}
@end
@implementation AddressRegionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _countryLabel = [[UILabel alloc] init];
        _countryLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_countryLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
        }];
        [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.contentView);
            make.left.equalTo(_titleLabel.mas_right).mas_offset(kScaleWidth(8));
        }];
        _titleLabel.text = LaguageControlAppend(@"国家");
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   if( [_delegate respondsToSelector:@selector(addressRegionClick:)])
   {
       [_delegate addressRegionClick:self];
   }
}
- (void)setCountry:(NSString *)country
{
    _country = country;
    _countryLabel.text = country;
}
@end
