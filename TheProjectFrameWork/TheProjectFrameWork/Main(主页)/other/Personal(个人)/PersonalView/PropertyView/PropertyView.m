//
//  PropertyView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PropertyView.h"

@implementation PropertyView
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc"] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end


@interface PropertyBalanceView ()
{
    UILabel * valueLabel;
}
@end
@implementation  PropertyBalanceView
{
    UILabel * label;
    UIButton * sender;
    UIButton *tianxianBtn;
}
- (instancetype)initWithFrame:(CGRect)frame withTyep:(NSInteger )type
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        label = [[UILabel alloc] initWithText:@"账户余额"];
        label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
        label.textColor = [UIColor colorWithString:@"#666666"];
        valueLabel = [[UILabel alloc] initWithText:nil];
        valueLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:kAppAsiaFontSize(27)];
//        valueLabel.numberOfLines = 2;
        valueLabel.textColor = [UIColor colorWithString:@"#C90C1E"];
        sender = [UIButton buttonWithType:UIButtonTypeCustom];
        [sender setTitle:[LaguageControl languageWithString:@"充值"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"jifenshangcheng"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        sender.tag = 101;
        [sender addTarget:self action:@selector(clickRecharge:) forControlEvents:UIControlEventTouchUpInside];
        
        
        tianxianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tianxianBtn setTitle:@"提现" forState:UIControlStateNormal];
        [tianxianBtn setBackgroundImage:[UIImage imageNamed:@"jifenshangcheng"] forState:UIControlStateNormal];
        [tianxianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tianxianBtn.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        tianxianBtn.tag = 102;
        [tianxianBtn addTarget:self action:@selector(clickRecharge:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"subCash"]) {
                    tianxianBtn.hidden = NO;

        }else{
                    tianxianBtn.hidden = YES;

        }
        
        [self addSubview:label];
        [self addSubview:valueLabel];
        [self addSubview:sender];
        __weak typeof(self) weakSelf = self;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(25));
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(15));
        }];
        [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(44));
            make.right.mas_equalTo(sender.mas_left).offset(kScaleWidth(-5));
            
        }];
        if (type==1) {
            [self addSubview:tianxianBtn];
            /**余额*/
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"subCash"]) {
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(weakSelf).offset(-30);
                    make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
                    make.height.equalTo(valueLabel.mas_height).mas_offset(-kScaleHeight(5));
                }];
            }else{
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(weakSelf).offset(0);
                    make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
                    make.height.equalTo(valueLabel.mas_height).mas_offset(-kScaleHeight(5));
                }];
            }
            
            [tianxianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf).offset(+30);
                make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
                make.height.equalTo(valueLabel.mas_height).mas_offset(-kScaleHeight(5));
            }];
        }else{
            /**金币*/
            [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf);
                make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
                make.height.equalTo(valueLabel.mas_height).mas_offset(-kScaleHeight(5));
            }];
        }
        
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = [LaguageControl languageWithString:title];
    label.text = [LaguageControl languageWithString:title];
}
- (void)setAccessTitle:(NSString *)accessTitle
{
    _accessTitle = [LaguageControl languageWithString:accessTitle];
    [sender setTitle:[LaguageControl languageWithString:accessTitle] forState:UIControlStateNormal];
}
- (void)clickRecharge:(UIButton *)btn
{
    if([_delegate respondsToSelector:@selector(propertyBalanceRechargeWithTag:)])
    {
        [_delegate propertyBalanceRechargeWithTag:btn.tag];
    }
}
- (void)setValue:(double)value
{
//    [super setValue:value];
    valueLabel.text = [NSString stringWithFormat:@"%.2lf",value];
}
@end

@interface PropertyRebateView ()
{
    UILabel * valueLabel;
}
@end
@implementation PropertyRebateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] initWithText:@"返利金额"];
        label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
        label.textColor = [UIColor colorWithString:@"#666666"];
        valueLabel = [[UILabel alloc] initWithText:nil];
        valueLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(30)];
        valueLabel.textColor = [UIColor colorWithString:@"#C90C1E"];
        [self addSubview:label];
        [self addSubview:valueLabel];
        __weak typeof(self) weakSelf = self;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(25));
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(15));
        }];
        [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
    }
    return self;
}
- (void)setValue:(double)value
{
    valueLabel.text = [NSString stringWithFormat:@"%.2lf",value];
//    [super setValue:value];
}
@end
