//
//  BasePopView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BasePopView.h"

@implementation BasePopView
- (instancetype)initWithFrame:(CGRect)frame
{
    frame = kScreenFreameBound;
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithString:@"#000000120"];
        UIView * contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        __weak typeof(self) weakSelf = self;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
            make.height.equalTo(contentView.mas_width).multipliedBy(0.618f).priority(750);
            make.width.equalTo(weakSelf.mas_width).mas_offset(-kScaleWidth(18));
        }];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 3;
        contentView.layer.masksToBounds = YES;
        _contentView = contentView;
        self.alpha = 0;
    }
    return self;
}

- (void)displayFromWindow
{
    [KeyWindow addSubview:self];

    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
    }];
}
- (void)removeFromWindow
{
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
