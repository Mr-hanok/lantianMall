//
//  BaseOrderPopView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseOrderPopView.h"
@interface BaseOrderPopView ()
@end
@implementation BaseOrderPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel * titleLabel = [[UILabel alloc] initWithText:nil];
        UIButton * cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * sure = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:cancel];
        [self.contentView addSubview:sure];
        _titleLabel = titleLabel;
        _cancel = cancel;
        _sure = sure;
        [self layoutViews];
    }
    return self;
}
- (void)layoutViews
{
    _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
    _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
    _titleLabel.layer.borderWidth = 0.5f;
    _titleLabel.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
    [_cancel setTitle:[LaguageControl languageWithString:@"取消"] forState:UIControlStateNormal];
    [_sure setTitle:[LaguageControl languageWithString:@"确定"] forState:UIControlStateNormal];
    [_cancel addTarget:self action:@selector(removeFromWindow) forControlEvents:UIControlEventTouchUpInside];
    [_sure addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
    [_cancel setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
    [_sure setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.contentView).mas_offset(-1);
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(1);
        make.height.mas_equalTo(kScaleHeight(50));
    }];
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(weakSelf.contentView);
        make.right.equalTo(_sure.mas_left).mas_offset(-0.5f);
        make.height.mas_equalTo(kScaleHeight(45));
    }];
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(weakSelf.contentView);
        make.width.equalTo(_cancel.mas_width);
        make.height.equalTo(_cancel.mas_height);
        
    }];
    UIView * minLine = [UIView new];
    UIView * line = [UIView new];
    [self.contentView addSubview:minLine];
    [self.contentView addSubview:line];
    [minLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.left.equalTo(_cancel.mas_right);
        make.width.mas_equalTo(0.5f);
        make.height.equalTo(_cancel.mas_height);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_cancel.mas_top);
        make.right.left.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    minLine.backgroundColor = [UIColor colorWithString:@"#cccccc"];
    line.backgroundColor = minLine.backgroundColor;
}
- (void)sureEvent
{
    
}
@end
