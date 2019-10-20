//
//  MineHeaderLanguageView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineHeaderLanguageView.h"
#import "MineSelectLanguaeView.h"
@interface MineHeaderLanguageView ()<MineSelectLanguaeViewDelegate>
{
    UILabel * _languageLabel;
    UIImageView * _languageImage;
    UIView * _contentView;
    MineSelectLanguaeView * selectView;
    NSString * _currentStr;
}
@end
@implementation MineHeaderLanguageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _languageLabel = [[UILabel alloc] initWithText:nil];
        _languageLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(11)];
        _languageImage = [[UIImageView alloc]initWithImage:nil];
        _languageImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_languageImage];
        [self addSubview:_languageLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    __weak typeof(self) weakSelf = self;
    [_languageImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf).mas_offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-5);
        make.width.mas_greaterThanOrEqualTo(kScaleWidth(20));
    }];
    [_languageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(weakSelf);
        make.left.equalTo(_languageImage.mas_right).mas_offset(2);
        make.width.mas_greaterThanOrEqualTo(weakSelf.mas_width).multipliedBy(0.5f);
    }];
}
- (instancetype)initWithCurretnStr:(NSString *)current
{
    self = [super init];
    if(self)
    {
        _currentStr = current;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
        selectView = [[MineSelectLanguaeView alloc] initWithCurrentTitle:_currentStr];
        selectView.delegate = self;
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:selectView];
        __weak typeof(window) weakWindow = window;
        [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakWindow);
        }];
        [selectView layoutIfNeeded];
 
    
    [selectView startAppear];
}
#pragma mark - delegate
- (void)mineSelectLanguageWithLanguage:(LanguageTypes)language
{
    if([_delegate respondsToSelector:@selector(mineHeaderLanguage:)])
    {
        [_delegate mineHeaderLanguage:language];
    }
}
- (void)setCurrentTitle:(NSString *)currentTitle
{
    _languageLabel.text = currentTitle;
}
- (void)setCurrentImage:(UIImage *)currentImage
{
    _languageImage.image = currentImage;
}
@end
