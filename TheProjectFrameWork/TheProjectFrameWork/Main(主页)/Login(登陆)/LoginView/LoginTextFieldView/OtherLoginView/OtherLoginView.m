//
//  OtherLoginView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OtherLoginView.h"
#import "LineWordsView.h"
#import "OtherButton.h"
@interface OtherLoginView ()<OtherButtonDelegate>
{
    LineWordsView * _line;
    OtherButton * _faceBookBtn;
}
@end
@implementation OtherLoginView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _line = [[LineWordsView alloc] initWithWords:[LaguageControl languageWithString:@"其他登陆方式"]];
        _faceBookBtn = [[OtherButton alloc] initWithTitle:@"Facebook" titleColor:[UIColor colorWithString:@"#1e5b9a"] image:[UIImage imageNamed:@"f"]];

        [self addSubview:_line];
        [self addSubview:_faceBookBtn];

        [self setup];
    }
    return self;
}
- (void)setup
{
    _faceBookBtn.delegate = self;
    __weak typeof(self) weakSelf = self;
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(kScaleHeight(25));
    }];
    [_faceBookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.25f);
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).mas_offset(kScaleHeight(10));
    }];

}
#pragma mark - OtherButtonDelegate
- (void)clickButtonWithTitle:(NSString *)title
{
   if( [self.delegate respondsToSelector:@selector(otherLoginWithTitle:)])
   {
       [self.delegate otherLoginWithTitle:title];
   }
}
@end
