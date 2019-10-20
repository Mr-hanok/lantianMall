//
//  SellerAccountCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SellerAccountCell.h"

@implementation SellerAccountCell
{
    UILabel * label;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        label.textColor = [UIColor colorWithString:@"#333333"];
        [self.contentView addSubview:label];
        __weak typeof(self) weakSelf = self;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(8));
        }];
    }
    return self;
}
- (void)setAccount:(NSString *)account
{
    _account = account;
    label.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"账 户 号"],account];
}
@end
